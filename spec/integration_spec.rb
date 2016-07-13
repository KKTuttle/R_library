# require('capybara/rspec')
# require('./app')
# Capybara.app = Sinatra::Application
# set(:show_exceptions, false)
#
# describe('adding a book', {:type => :feature}) do
#   it('allows a user to add a book') do
#     visit('/')
#     fill_in('name', :with => "Harry Potter")
#     fill_in('author', :with => "J.K.Rowling")
#     click_button('Add')
#     expect(page).to have_content("Harry Potter")
#   end
# end
