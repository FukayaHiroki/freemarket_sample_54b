crumb :root do
  link "メルカリ", root_path
end

crumb :user_mypage do 
  link "マイページ", "/users/#{current_user.id}"
  parent :root
end

crumb :profile do
  link "プロフィール", profile_user_path(current_user.id)
  parent :user_mypage
end

crumb :user_sign_out do
  link "ログアウト"
  parent :user_mypage
end

crumb :identification do
  link "本人情報の確認", identification_user_path
  parent :user_mypage
end

crumb :cards_index do
  link "支払い方法", user_cards_path
  parent :user_mypage
end

crumb :cards_new do
  link "クレジットカード情報入力", new_user_card_path
  parent :cards_index
end

crumb :products_show do
  link Product.find(params[:id]).name, products_path(Product.find(params[:id]))
  parent :root
end
# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).