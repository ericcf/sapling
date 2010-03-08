module SaplingFormTagHelper

  include ActionView::Helpers::FormTagHelper

  def submit_tag(value, options={})
    cancel_value = options[:cancel_value] || nil
    cancel_url = options[:cancel_url]
    @template.render(:partial => 'shared/forms/submit_tag',
       :locals => { :tag => super(value, options),
                    :cancel_value => cancel_value,
                    :cancel_url => cancel_url })
  end
end