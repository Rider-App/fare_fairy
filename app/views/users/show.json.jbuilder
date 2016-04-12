json.user_id @user.id
json.email @user.email
json.token @user.session_tokens.last.token
json.success "OK"
