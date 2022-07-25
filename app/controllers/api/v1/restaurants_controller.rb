class Api::V1::RestaurantsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [:index, :show]
  # isso pé para pular a parte de autenticação do DEVISE, mas
  # vamos continuar fazendo a autenticação pelo PUNDIT
  # não precisa estar logado para rodar o Show
  # skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_restaurant, only: [ :show, :update, :destroy ]

  def index
    # porque usamos o pundit, não usaremos o comando aqui:
    # @restaurants = Restaurant.all
    # mas usaremos o scope.all no RestaurantPolicy
    @restaurants = policy_scope(Restaurant)
    # e, se não usássemos o pundit, e quiséssemos fazer "user igual ao current_user"
    # @restaurants = Restaurant.where(user: current_user)
    # faríamos scope.where(user: current_user)
  end

  def show
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    authorize @restaurant
    if @restaurant.save
      # o status: manda um código diferente, dizendo que não é apenas o SHOW
      # diz que algo diferente foi criado
      render :show, status: :created
    else
      render_error
    end
  end

  def update
    # para fazer o UPDATE, devemos fazer o mesmo d=que foi feito no SHOW
    # então, para não repetir, criamos um método (set_restaurant)
    # e para chamar o método usamos o before_action acima
    if @restaurant.update(restaurant_params)
      # que tipo de json gostariamos deapresentar para o usuario depois de atualizar?
      # queremos mostrar o show
      render :show
    else
      # se o update não der certo, o que fazer?
      # devemos mandar um json dizendo: deu errado
      # mas devemos saber quem é o usuario
      render_error
    end
  end

  def destroy
    @restaurant.destroy
    # não precisa criar uma view json para mostrar que destruiu
    # como este: render json: { message: 'deu certo a exclusão' }, status: :ok
    # é só mandar esta linha abaixo dizendo que não tem conteúdo
    head :no_content
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    # agora precisa autorizar porque o PUNDIT sempre pede isso
    authorize @restaurant
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address)
  end

  def render_error
    render json: { errors: @restaurant.errors.full_messages },
    status: :unprocessable_entity
  end
end
