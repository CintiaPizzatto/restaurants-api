class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all # este scope.all é o mesmo do que um Restaurant.all
    end
  end

  def show?
    # que tipo de usuário pode ver meu restaurante?
    # poderia ser só quem está logado, mas, neste caso, vamos deixar para todos
    true
  end

  def create?
    # qual tipo de usuario pode criar o restaurante? todos!
    true
  end

  def update?
    # quem pode fazer o UPDATE? o dono do restaurante
    # pegamos o record (que é o restaurante que estamos passando)
    # e vemos se o user daquele restaurante é igual ao current user (user)
    # isso é PUNDIT
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
