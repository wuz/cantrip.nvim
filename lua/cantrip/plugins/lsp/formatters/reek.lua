local null_ls = require("null-ls")
local h = require("null-ls.helpers")
local u = require("null-ls.utils")

local handle_reek_output = function(params)
  if params.output then
    local parser = h.diagnostics.from_json({
      severities = {
        error = h.diagnostics.severities.error,
      },
    })
    local offenses = {}

    for _, offense in ipairs(params.output) do
      table.insert(offenses, {
        message = offense.context .. " " .. offense.message,
        ruleId = offense.smell_type,
        level = "error",
        line = offense.lines[0],
        endLine = offense.lines[#offense.lines],
      })
    end

    return parser({ output = offenses })
  end
  return {}
end

return {
  name = "reek",
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { "ruby" },
  generator = null_ls.generator({
    command = "reek",
    args = { "--format", "json", "--no-color", "--stdin-filename", "$FILENAME" },
    to_stdin = true,
    from_stderr = true,
    format = "json",
    check_exit_code = function(code)
      return code <= 1
    end,
    cwd = function(params)
      return u.root_pattern(".reek.yml")(params.bufname)
    end,
    use_cache = true,
    on_output = handle_reek_output,
  }),
}
