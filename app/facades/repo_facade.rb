class RepoFacade

  def repos
    repo_data = github_service.repo_info
    repo_data.map do |repo|
      Repo.new(repo)
    end
  end

  private

  def github_service
    GithubService.new
  end

end
