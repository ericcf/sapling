ActionController::Routing::Routes.draw do |map|
  # admin
  map.connect '/@admin',
    :conditions => { :method => :get },
    :controller => 'admin/admin',
    :action => 'index'
  map.namespace :admin, :path_prefix => '@admin' do |admin|
    admin.resources 'sections', :has_many => :chunks
    admin.resources 'users'
    admin.connect 'workflow/update_state',
      :conditions => { :method => :put },
      :controller => 'workflow',
      :action => :update_state
  end

  # users
  map.user_login_form '/@users/login',
    :conditions => { :method => :get },
    :controller => :users,
    :action => :login_form
  map.user_login '/@users/login',
    :conditions => { :method => :post },
    :controller => :users,
    :action => :login
  map.user_logout '/@users/logout',
    :conditions => { :method => :get },
    :controller => :users,
    :action => :logout

  # tags
  map.resources :tag_collections,
    :as => '@tag_collections'
  map.connect '/@tags/create_association',
    :conditions => { :method => :post },
    :controller => :tags,
    :action => :create_association
  map.connect '/@tags/destroy_association',
    :conditions => { :method => :post },
    :controller => :tags,
    :action => :destroy_association

  # events calendar
  map.calendar '/@calendar/:year/:month',
    :controller => 'calendar',
    :action => 'index',
    :year => Time.zone.now.year,
    :month => Time.zone.now.month

  # news feed
  map.connect '/@news_feed.xml', :controller => 'news_items', :action => 'rss_feed'

	# news items
	map.connect '/@news_items/:id.:format',
		:conditions => { :method => :get },
		:controller => 'news_items',
		:action => 'show'

  # email sharing
  map.connect '/@email/:content_type/:content_id',
    :conditions => { :method => :get },
    :controller => 'shared_emails',
    :action => 'new'
  map.connect '/@email/:content_type/:content_id',
    :conditions => { :method => :post },
    :controller => 'shared_emails',
    :action => 'create'

  # nodes
  map.connect '/@node_list', :controller => 'nodes', :action => 'node_list'
  map.connect '@new/*node_path',
    :conditions => { :method => :get },
    :controller => 'nodes',
    :action => 'new'
  map.connect '@edit/*node_path',
    :conditions => { :method => :get },
    :controller => 'nodes',
    :action => 'edit'
  map.connect '*node_path',
    :conditions => { :method => :get },
    :controller => 'nodes',
    :action => 'show'
  map.root :controller => 'nodes', :action => 'show', :conditions => { :method => :get }
  map.connect '*node_path',
    :conditions => { :method => :post },
    :controller => 'nodes',
    :action => 'create'
  map.connect '*node_path',
    :conditions => { :method => :put },
    :controller => 'nodes',
    :action => 'update'
  map.connect '*node_path',
    :conditions => { :method => :delete },
    :controller => 'nodes',
    :action => 'destroy'
end
