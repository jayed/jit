
require_relative "../diff"
    Target = Struct.new(:path, :oid, :mode, :data) do
      blob  = repo.database.load(entry.oid)

      Target.new(path, entry.oid, entry.mode.to_s(8), blob.data)
      blob  = repo.database.load(entry.oid)

      Target.new(path, entry.oid, entry.mode.to_s(8), blob.data)
      Target.new(path, oid, mode.to_s(8), blob.data)
      Target.new(path, NULL_OID, nil, "")

      hunks = ::Diff.diff_hunks(a.data, b.data)
      hunks.each { |hunk| print_diff_hunk(hunk) }
    end

    def print_diff_hunk(hunk)
      puts hunk.header
      hunk.edits.each { |edit| puts edit }