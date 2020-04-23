module App
  def self.set_preferences(prefs)
    @preferences = prefs || Hash.new
  end

  def self.preferences
    @preferences
  end
end
