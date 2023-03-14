local model = {}

function nmorqw(nm, qw)
  return vim.g.is_norman and nm or qw;
end
model.nmorqw = nmorqw;

return model;
