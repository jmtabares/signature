# Helper class.
module FileUtilities
  # Creates directory together with parent directories if they do not exist
  # Dir.mkdir only creates folders whose parents exist
  def mkdir(directory)
    tmp_folder = ''
    # split fullpath directory into separate folder nodes
    directory.split('/').each do |folder|
      # append child folder to parent directory
      tmp_folder << "#{folder}/"
      # creates folder in directory tree
      Dir.mkdir tmp_folder unless File.directory? tmp_folder
    end
  end
end
