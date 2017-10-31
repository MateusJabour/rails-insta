require 'test_helper'

class CreatePhotoTest < ActionDispatch::IntegrationTest
  test "create photo" do
    user = FactoryBot.create(:user)
    photo = FactoryBot.attributes_for(:photo)

    login_as(user)

    visit create_photo_path(user.id)

    attach_file 'photo_image', photo[:image].path, make_visible: true
    fill_in 'Description', with: photo[:description]

    click_on 'Upload photo'
    wait_for_ajax
    
    assert page.has_current_path?(user_page_path(user))
    assert page.find_by_id(Photo.last.id)
  end
end
