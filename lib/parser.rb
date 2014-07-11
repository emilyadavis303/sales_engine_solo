class Parser

  def parse(filename, klass, repo_ref)
    repository = CSV.open(filename, headers: true, header_converters: :symbol)
    repository.map {|row| klass.new(row, repo_ref)}
  end

end
