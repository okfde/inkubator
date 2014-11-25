require 'spec_helper'

feature "Frontpage" do
  scenario "needs to be signed in" do
    visit "/"
    expect(page).to have_content("anmelden")
  end
  context 'logged in user' do
    before :each do
      user = create(:user)
      login_as(user, scope: :user)
    end
    context 'filter ideas' do
      scenario 'show active ideas by default' do
        visit '/'
        expect(page).to have_select("by_type", selected: 'aktive')
      end
      scenario 'can select type of ideas' do
        visit '/'
        expect(page).to have_selector('h3 select#by_type')
      end
      scenario 'can change type of ideas' do
        visit '/'
        select('abgeschlossene', from: 'by_type')
        expect(page).to have_select("by_type", selected: 'abgeschlossene')
      end
    end
    context 'order ideas' do
      scenario 'default order is by date' do
        visit '/'
        expect(page).to have_select("order", selected: 'Datum')
      end
      scenario 'can change order' do
        visit '/'
        expect(page).to have_selector('h3 select#order')
      end
    end
    context 'phase filter ideas' do
      scenario 'default phase filter is none' do
        visit '/'
        expect(page).to have_select("by_phase", selected: 'none')
      end
    end
  end
end
