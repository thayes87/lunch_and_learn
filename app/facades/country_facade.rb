class CountryFacade
  def self.find_country
    rand_country = CountryService.get_random_country
  end
end