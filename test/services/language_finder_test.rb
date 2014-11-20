require 'test_helper'

class LanguageFinderTest < MiniTest::Test

  def test_assigning_parameters
    assert_equal params, language_finder.params
  end

  def test_getting_user_name
    assert_equal params[:name], language_finder.user_name
  end

  def test_choosing_favorite_language
    Github::Client::Repos.stubs(:new).returns(repos)

    assert_equal "C", language_finder.favorite
  end

  def test_choosing_favorite_language_without_repos
    Github::Client::Repos.stubs(:new).returns(no_repos)

    assert_equal nil, language_finder.favorite
  end

  def test_choosing_favorite_language_with_nil_languages
    Github::Client::Repos.stubs(:new).returns(repos_with_nil)

    assert_equal "Ruby", language_finder.favorite
  end

  private

  def language_finder
    LanguageFinder.new(params)
  end

  def repos
    mock(list: repos_list)
  end

  def no_repos
    mock(list: [])
  end

  def repos_with_nil
    mock(list: repos_list_nil)
  end

  def lang(name)
    mock(language: name)
  end

  def params
    { name: 'palin' }
  end

  def repos_list
    [lang("CSS"), lang("Ruby"), lang("Ruby"), lang("C"), lang("C"), lang("C")]
  end

  def repos_list_nil
    [lang(nil), lang("Ruby"), lang(nil)]
  end
end
