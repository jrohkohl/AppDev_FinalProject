task({:sim=> :environment}) do 

  main_array = []
  sub_array = []
  check_user = User.where({ :id => 1 }).at(0)
  all_users = User.all.order({ :created_at => :desc })
  all_rest = Restaurant.all.order({ :created_at => :desc })
  

  all_users.each do |u|

    sum_product = 0.0
    sum_check_sq = 0.0
    sum_u_sq = 0.0

    if u.id != check_user.id
      
      all_rest.each do |r|

        adj_check_rating = 0
        adj_u_rating = 0


        check_rating = check_user.ratings.where({ :restaurant_id => r.id }).at(0)
      

        u_rating = u.ratings.where({ :restaurant_id => r.id }).at(0)

        
        
        
        if check_rating.nil?  
          adj_check_rating = 0

        elsif check_rating.rating == 2 || check_rating.rating == 3
          adj_check_rating = 0
        
        elsif  check_rating.rating == 4 || check_rating.rating == 5
          adj_check_rating = 1
        else
          adj_check_rating = -1
        end

        if u_rating.nil?
          adj_u_rating = 0

        elsif u_rating.rating == 2 || u_rating.rating == 3
          adj_u_rating = 0
        
        elsif  u_rating.rating == 4 || u_rating.rating == 5
          adj_u_rating = 1
        else
          adj_u_rating = -1
        end
        
        sum_product = sum_product + (adj_u_rating * adj_check_rating)
        sum_check_sq = (adj_check_rating ** 2) + sum_check_sq
        sum_u_sq = (adj_check_rating ** 2) + sum_u_sq


      end 
      user_sim = sum_product / ((sum_check_sq ** 0.5) * (sum_u_sq ** 0.5))
    else 
      user_sim = 0.0
    end 

    



    #sub_array = [user_sim.to_f, u.id]
    #main_array.push(sub_array)


  end

  #main_array.sort do |a, b|
    #b.at(-1) <=> a.at(-1)
  #end

  #p main_array.at(0)
  #p main_array.at(1)
  #p main_array.at(2)
  

  




end