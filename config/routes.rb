Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json }  do   # com o namespace crio a url localhost/api/restaurants
    # se não colocar que o formato padrão é json, quando escrevo a url
    # o navegador vai tentar recuperar um HTML, mas como eu quero uma API
    # eu quero que o navegador recupere um JSON
    # se eu não colocar {format: :json} , então no final da URL eu teria que
    # escrever: "localhost:3000\api\v1\restaurants.json"
    # Assim, eu quero que qualquer coisa, na rota dentro da api,seja um json
    # então, a linha 3 diz: por padrão, tudo que está dentro do namespace é um JSON
    namespace :v1 do  # com o namespace crio a url localhost/api/v1/restaurants
      # o v1 é a versão do teu API
      resources :restaurants, only: [:index, :show, :update, :create, :destroy ]
    end
    # se quiser criar a versão 2, faz assim:
    # namespace :v2 do
    # end
  end
  root to: 'pages#home'      # deixo esta linha?

end
