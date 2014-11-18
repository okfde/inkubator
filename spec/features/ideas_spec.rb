require 'spec_helper'

feature "Frontpage" do
  scenario "needs to be signed in" do
    visit "/"
    expect(page).to have_content("anmelden")
  end
end
