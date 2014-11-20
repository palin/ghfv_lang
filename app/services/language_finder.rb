class LanguageFinder
  attr_reader :params, :user_name

  def initialize(params)
    @params = params
    @user_name = params[:name]
  end

  def favorite
    langs = languages(repos)
    find_favorite(langs)
  end

  private

  def client_repos
    Github::Client::Repos.new
  end

  def repos
    client_repos.list user: user_name
  end

  def languages(repos)
    langs = []

    repos.each do |repo|
      langs.push repo.language
    end

    langs.compact
  end

  def find_favorite(langs)
    hash = langs.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    hash.max_by(&:last).first if hash.present?
  end
end