module ApplicationHelper

  def full_title(page_title=" ")
    base_title = "TikiTiki"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def find_quantity(drink, ingredient)
    di = DrinkIngredient.find_by(:drink_id => drink.id, :ingredient_id => ingredient.id)
    
    if di
      di.quantity 
    else
      ""
    end
  end
  
end
