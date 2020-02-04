-- TODO: Use an official version of a tablecopy
function table.shallow_copy(t)
    local u = {}
    for k, v in pairs(t) do u[k] = v end
    return u
end

-- http://lua-users.org/wiki/CopyTable
-- Save copied tables in `copies`, indexed by original table.
function table.deep_copy(orig, copies)
    copies = copies or {}
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            copies[orig] = copy
            for orig_key, orig_value in next, orig, nil do
                copy[table.deep_copy(orig_key, copies)] = table.deep_copy(orig_value, copies)
            end
            setmetatable(copy, table.deep_copy(getmetatable(orig), copies))
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end