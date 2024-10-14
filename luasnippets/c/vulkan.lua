local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require 'luasnip.extras.fmt'.fmt
local fmta = require 'luasnip.extras.fmt'.fmta
local rep = require 'luasnip.extras'.rep

local function copy(args)
	return args[1]
end

local function uncapitalize(s)
	return s:sub(1, 1):lower() .. s:sub(2)
end

local function to_upper_snake(s)
	return s:gsub('[A-Z]', '_%1'):upper()
end

return {
	s({ trig = 'vst' }, fmta([[
    Vk<> <>
  ]], {
		i(1),
		d(2, function(args)
			return sn(nil, fmta([[
        <1>;
        <2>.sType = <3>;
        <2>.pNext = NULL;
      ]], {
				i(1, uncapitalize(args[1][1])),
				f(copy, 1),
				f(function(args) return 'VK_STRUCTURE_TYPE_' .. to_upper_snake(args[1][1]) end, 1),
			}))
		end, 1)
	})),
	s({ trig = 'vmk' }, fmta([[
    Vk<1>CreateInfo <2>;
    <3>.sType = <4>;
    <3>.pNext = NULL;
    <5>
  ]], {
		i(1),
		i(2, "createInfo"),
		f(copy, 2),
		f(function(args) return 'VK_STRUCTURE_TYPE' .. to_upper_snake(args[1][1]) .. '_CREATE_INFO' end, 1),
		d(3, function(args)
			return sn(nil, fmta([[
        Vk<1> <2>;
        vkCreate<1>(&<3>, NULL, &<4>);
      ]], {
				t(args[1][1]),
				i(1, uncapitalize(args[1][1])),
				t(args[2][1]),
				f(copy, 1)
			}))
		end, { 1, 2 })
	})),
	s({ trig = 'appinfo' }, fmta([[
    VkApplicationInfo <1>;
    <2>.pNext = NULL;
    <2>.sType = VK_STRUCTURE_TYPE_APPLICATION_INFO;
    <2>.apiVersion = VK_API_VERSION_<3>;
    <2>.pApplicationName = <4>;
    <2>.applicationVersion = <5>;
    <2>.pEngineName = <6>;
    <2>.engineVersion = <7>;
  ]], {
		i(1, 'appinfo'), f(copy, 1), i(2, '1_0'),
		i(3, '"Application Name"'), i(4, 'VK_MAKE_VERSION(1, 0, 0)'),
		i(5, '"No Engine"'), i(6, 'VK_MAKE_VERSION(1, 0, 0)'),
	})),
	s({ trig = 'mkinstance' }, fmta([[
    VkInstanceCreateInfo <1>;
    <2>.sType = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;
    <2>.pNext = NULL;
    <2>.pApplicationInfo = <3>;
    <2>.enabledLayerCount = <4>;
    <2>.ppEnabledLayerNames = <5>;
    <2>.enabledExtensionCount = <6>;
    <2>.ppEnabledExtensionNames = <7>;
    <2>.flags = <8>;

    VkInstance <9>;
    VkResult result = vkCreateInstance(&<2>, NULL, &<10>);
    if (result != VK_SUCCESS) {
        fprintf(stderr, "Failed to create instance\n");
        exit(1);
    }
  ]], {
		i(1, "instanceCreateInfo"), f(copy, 1),
		i(2, "&appinfo"),
		i(3, "0"),
		i(4, "NULL"),
		i(5, "0"),
		i(6, "NULL"),
		i(7, "0"),
		i(8, "instance"), f(copy, 8),
	}))
}
