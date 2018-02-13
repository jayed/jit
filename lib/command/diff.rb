      if @args.first == "--cached"
        diff_head_index
      else
        diff_index_workspace
    def diff_head_index
      @status.index_changes.each do |path, state|
        case state
        when :added    then print_diff(from_nothing(path), from_index(path))
        when :modified then print_diff(from_head(path), from_index(path))
        when :deleted  then print_diff(from_head(path), from_nothing(path))
        end
      end
    end
    def diff_index_workspace
      @status.workspace_changes.each do |path, state|
        case state
        when :modified then print_diff(from_index(path), from_file(path))
        when :deleted  then print_diff(from_index(path), from_nothing(path))
        end
      end
    end
    def from_head(path)
      entry = @status.head_tree.fetch(path)
      Target.new(path, entry.oid, entry.mode.to_s(8))
    end
    def from_index(path)
      entry = repo.index.entry_for_path(path)
      Target.new(path, entry.oid, entry.mode.to_s(8))
    def from_file(path)
      blob = Database::Blob.new(repo.workspace.read_file(path))
      oid  = repo.database.hash_object(blob)
      mode = Index::Entry.mode_for_stat(@status.stats[path])
      Target.new(path, oid, mode.to_s(8))
    end
    def from_nothing(path)
      Target.new(path, NULL_OID, nil)
      if a.mode == nil
        puts "new file mode #{ b.mode }"
      elsif b.mode == nil