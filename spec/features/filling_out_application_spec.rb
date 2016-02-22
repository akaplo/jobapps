require 'rails_helper'

describe 'filling out an application' do
  let(:application) do
    create :application_template, :with_questions
  end

  before :each do
    when_current_user_is :student, integration: true
    visit application_path(application)
  end

  context 'answered all required questions' do
    it 'redirects to the student dashboard' do
      click_on 'Submit application'
      expect(page.current_url).to eql student_dashboard_url
    end

    it 'renders the application receipt flash message' do
      expect_flash_message(:application_receipt)
      click_on('Submit application')
    end
  end
end
