
[
	(record_definition)
	(block)
	(argument_list)
	(tuple)
	(list)
] @indent.begin
;
(record_definition "}" @indent.branch @indent.end)
(block "}" @indent.end @indent.branch)
(argument_list ")" @indent.branch @indent.end)
(tuple ")" @indent.branch @indent.end)
(list "]" @indent.branch @indent.end)
