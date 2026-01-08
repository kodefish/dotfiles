local M = {}

-- Function to dynamically find Python executable based on project setup
function M.get_python_path()
	local cwd = vim.fn.getcwd()

	-- Check for UV workspace (uv.lock at root)
	if vim.fn.filereadable(cwd .. "/uv.lock") == 1 then
		local uv_python = cwd .. "/.venv/bin/python"
		if vim.fn.executable(uv_python) == 1 then
			return uv_python
		end
	end

	-- Check for Pixi (pixi.lock or .pixi directory)
	if vim.fn.filereadable(cwd .. "/pixi.lock") == 1 or vim.fn.isdirectory(cwd .. "/.pixi") == 1 then
		-- Pixi can have multiple environments, try common ones
		local pixi_envs = {
			cwd .. "/.pixi/envs/default/bin/python",
			cwd .. "/.pixi/envs/dev/bin/python",
		}
		for _, pixi_python in ipairs(pixi_envs) do
			if vim.fn.executable(pixi_python) == 1 then
				return pixi_python
			end
		end
	end

	-- Check for devcontainer (usually in .devcontainer)
	if vim.fn.isdirectory(cwd .. "/.devcontainer") == 1 then
		-- In devcontainer, Python is usually on the PATH
		if vim.fn.executable("python") == 1 then
			return "python"
		end
	end

	-- Check for standard venv
	local venv_python = cwd .. "/.venv/bin/python"
	if vim.fn.executable(venv_python) == 1 then
		return venv_python
	end

	-- Fallback to system python
	return "python3"
end

return M
