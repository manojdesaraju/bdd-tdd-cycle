require 'rails_helper'
RSpec.describe MoviesController, type: :controller do
  describe "GET #movie" do
      
  before :each do
   @movie1= Movie.create(
      title: 'Star Wars',
      rating: 'PG',
      director: 'George Lucas',
      release_date: '1977-05-25'
    )
   @movie2= Movie.create(
      title: 'Blade Runner',
      rating: 'PG',
      director: 'Ridley Scott',
      release_date: '1982-06-25'
    )
   @movie3= Movie.create(
      title: 'Alien',
      rating: 'R',
      release_date: '1979-05-25',
    )
    @movie4=Movie.create(
      title: 'THX-1138',
      rating: 'R',
      director: 'George Lucas',
      release_date: '1971-03-11',
    )

  end
    it "renders the movie index" do
      get :index
      expect(response).to render_template("movies/index")
    end
    it "updates the movie info and redirects to show page  " do
      put :update, id: @movie2, :movie=>{:director=>"Ridley scott"}
      @movie2.reload
      @movie2.director.should eq "Ridley scott"
      expect(response).to redirect_to('/movies/'+@movie2.id.to_s)
    end
    it "check for similar movies " do
      get :similar, id: @movie1
      expect(response).to redirect_to('/movies/'+@movie1.id.to_s+'/find_similar_movies')
    end
    it "check for similar movies " do
      get :similar, id: @movie3
      expect(response).to redirect_to('/movies/')
    end

  end
end
