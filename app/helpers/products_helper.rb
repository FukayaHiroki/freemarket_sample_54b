module ProductsHelper
  def user_login
    `.item-change-box
       = link_to "#", class: "item-change-box__btn item-btn-edit" do
         商品の編集
       %p.text_center or
       = link_to "#", class: "item-change-box__btn item-btn-gray" do
         出品を一旦停止する
       = link_to "#", class: "item-change-box__btn item-btn-gray" do
         この商品を削除する`
  end
end
