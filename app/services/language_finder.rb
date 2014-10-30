class LanguageFinder
  attr_reader :params

  def initialize(params)
    @params = params
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
    client_repos.list user: username
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

  def username
    params[:name]
  end
end