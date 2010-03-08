module FieldsHelper

  def partial_for(content, field)
    value = content.send(field.name)
    return {} if value.blank?
    field_partial = "shared/fields/view/#{field.type}"
    { :partial => "shared/site/markup/#{field.display}",
      :locals => { :field => field,
                   :content => value,
                   :partial => field_partial }
    }
  end

  def render_date(date)
    render :partial => 'shared/fields/view/date', :locals => { :value => date }
  end
end
