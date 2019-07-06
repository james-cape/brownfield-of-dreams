# frozen_string_literal: true

class GithubUser
  attr_reader :name, :url
  def initialize(attributes)
    @name = attributes[:login]
    @url = attributes[:html_url]
  end
end