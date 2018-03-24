      setup_pager

    def header(string)
      puts fmt(:bold, string)
    end

      header("diff --git #{ a.path } #{ b.path }")
        header("new file mode #{ b.mode }")
        header("deleted file mode #{ a.mode }")
        header("old mode #{ a.mode }")
        header("new mode #{ b.mode }")
      header(oid_range)
      header("--- #{ a.diff_path }")
      header("+++ #{ b.diff_path }")
      puts fmt(:cyan, hunk.header)
      hunk.edits.each { |edit| print_diff_edit(edit) }
    end

    def print_diff_edit(edit)
      text = edit.to_s.rstrip

      case edit.type
      when :eql then puts text
      when :ins then puts fmt(:green, text)
      when :del then puts fmt(:red, text)
      end