require 'rails_helper'
include RSpecHtmlMatchers

describe 'interviews/interview.ics.erb' do
  before :each do
    @interview = create :interview
  end

  it 'Passes the correct field properties to the ics object' do
    render
    lines = {}
    rendered.each_line do |line|
      key, value = line.split ':', 2
      lines[key] = value.strip
    end
    expect(lines.fetch 'DTSTART')
      .to eql format_date_time @interview.scheduled, format: :iCal
    expect(lines.fetch 'DESCRIPTION')
      .to eql application_record_url(@interview.application_record)
    expect(lines.fetch 'SUMMARY').to eql @interview.calendar_title
    expect(lines.fetch 'UID')
      .to eql "INTERVIEW#{@interview.id}@UMASS_TRANSIT//JOBAPPS"
    expect(lines.fetch 'DTSTAMP')
      .to eql format_date_time Time.zone.now, format: :iCal
  end
end
