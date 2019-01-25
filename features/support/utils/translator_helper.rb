module Translator
  def self.translate_job_name(english_name, language)
    job = ''
    case language.upcase
    when 'ENG'
      job = english_name
    when 'ESP'
      job = return_translated_name('english_to_spanish.yml', 'jobs', english_name)
    when 'CAT'
      job = return_translated_name('english_to_catalan.yml', 'jobs', english_name)
    end
  end

  def self.translate_config_menu_name(language)
    english_name = 'Configuration'

    case language.upcase
    when 'ENG'
      configuration = english_name
    when 'ESP'
      configuration = return_translated_name('english_to_spanish.yml', english_name.downcase, english_name.downcase)
    when 'CAT'
      configuration = return_translated_name('english_to_catalan.yml', english_name.downcase, english_name.downcase)
    end
    configuration
  end

  def self.return_translated_name(file, key, english_name)
    data = DataMagic.load(file)
    data[key][english_name]
  end
end
