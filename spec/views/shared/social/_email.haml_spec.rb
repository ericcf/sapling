require File.dirname(__FILE__) + '/../../../spec_helper.rb'

describe '/shared/social/_email' do

  it 'links to the email form' do
    assigns[:content] = mock('content', :id => 1)
    render
    response.should have_tag("a[href=/@email/#{assigns[:content].class}/#{assigns[:content].id}]")
  end
end