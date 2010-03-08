$:.unshift File.join(File.dirname(__FILE__), '../../..')
require 'spec_helper.rb'

describe '/shared/fields/view/_date' do

  it 'renders day month year' do
    value = Date.today
    render :locals => { :value => value }
    response.should contain("#{value.day} #{Date::ABBR_MONTHNAMES[value.mon]} #{value.year}")
  end
end
