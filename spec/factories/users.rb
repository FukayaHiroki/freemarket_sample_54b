FactoryBot.define do
  factory :user do
    nickname                 {"テっちゃん"}
    email                    {"test@gmail.com"}
    password                 {"fortest"}
    password_confirmation    {"fortest"}
    family_name              {"テスト"}
    first_name               {"太郎"}
    family_name_kana         {"テスト"}
    first_name_kana          {"タロウ"}
    birthday                 {"2019-01-01"}
    phone                    {"09012345678"}
    created_at               { Date.today }
  end
end