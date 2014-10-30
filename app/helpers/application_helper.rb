module ApplicationHelper

  def user_language(language)
    language.presence || "Looks like this guy doesn't have repos..."
  end
end
