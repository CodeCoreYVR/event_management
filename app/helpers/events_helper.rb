module EventsHelper

  def team_members
    YAML.load_file("#{Rails.root}/config/team.yml").values
  end
end
