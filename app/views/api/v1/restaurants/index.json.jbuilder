json.array! @restaurants do |restaurant|
  # json.extract! restaurant, :id, :name, :address
  # se eu não quiser que no json tenha o address, é só fazer assim:
  json.extract! restaurant, :id, :name
  # json.extract! restaurant.user, :email #aqui pego os usuários associados ao restaurant
  # agora temos um array de hash para guardar todos os comentários de um restaurante
  # uso o objeto restaurants:
  # json.array! restaurant.comments do |comment| # os comentários associados ao restaurante
  #   json.extract! comment, :content
  #   json.extract! comment.user, :email
  # end

end

# extract: é o que estou extraindo para enviar para o json
# é o mesmo de:
# @restaurants.map do |restaurant| # isso me gera um array de Ruby
#  {
#  json << { restaurant.id, rastaurant.name, restaurant.adrress}
#  o mesmo que:
#  id: restaurant.id,
#  name: restaurant.name,
#  address: restaurant.address
#  }
#  eu estaria jogando para dentro do json estes campos
# end
