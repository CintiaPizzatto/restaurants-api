json.extract! @restaurant, :id, :name, :address
json.comments! @restaurant.comments do |comment| # os comentários associados ao restaurante
  json.extract! comment, :content
  json.extract! comment.user, :email
end
