module SystemTestAuthenticationHelpers
  def sign_in_user
    visit new_user_session_path

    fill_in "Email", with: @user.email
    fill_in "Password", with: "Password123!"

    # Force click the actual submit button ("Log in")
    click_button "Log in"

    assert_text "Sign out", wait: 3
  end
end

module SystemTestAuth
  def force_password!(user, password = "Password123!")
    user.update_columns(
      encrypted_password: Devise::Encryptor.digest(User, password),
      updated_at: Time.current
    )
  end
end
