require 'test_helper'

class InteractionsTest < ActionDispatch::IntegrationTest
    test "comment on a photo on the single photo page" do
      photo = FactoryBot.create(:photo)

      login_as(photo.user)
      visit photo_path(photo)

      fill_in "Comment", with: "My Comment"
      page.execute_script("$('#comment-form-#{photo.id}').submit()")
      wait_for_ajax

      assert page.has_current_path?(photo_path(photo))
      assert page.has_text?(photo.user.username)
      assert page.has_text?(photo.description)
      assert page.has_text?("My Comment")
    end

    test "like a photo on the single photo page" do
      photo = FactoryBot.create(:photo)

      login_as(photo.user)
      visit photo_path(photo)
      old_like_amount = photo.likes.count

      within("#single-photo-#{photo.id}") do
        click_on "Like button"
      end
      wait_for_ajax

      assert page.has_current_path?(photo_path(photo))
      assert old_like_amount < photo.likes.count
    end

    test "comment on a photo on the timeline" do
      photo = FactoryBot.create(:photo)

      login_as(photo.user)
      visit timeline_path

      fill_in "Comment", with: "My Comment"
      page.execute_script("$('#comment-form-#{photo.id}').submit()")
      wait_for_ajax

      assert page.has_current_path?(timeline_path)
      assert page.has_text?(photo.user.username)
      assert page.has_text?(photo.description)
      assert page.has_text?("My Comment")
    end

    test "like a photo on the timeline" do
      photo = FactoryBot.create(:photo)

      login_as(photo.user)
      visit timeline_path
      old_like_amount = photo.likes.count

      within("#single-photo-#{photo.id}") do
        click_on "Like button"
      end
      wait_for_ajax

      assert page.has_current_path?(timeline_path)
      assert_equal find("#like-counter-#{photo.id}").find('span').text.to_i, photo.likes.count
      assert_not_equal photo.likes.count, old_like_amount
    end
end
