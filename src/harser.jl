module harser

using JSON
using Base64

function write_context(name, context)
    file = open(name, "w")
    write(file, context)
    close(file)    
end

function init(file)
    file = open(file)
    context = JSON.parse(file)
    global entries = context["log"]["entries"]
end

function get_users()
    users_list = []
    for users in entries
        try
            feed = split(users["request"]["url"], "&")[3][3:14]
            push!(users_list, feed)
        catch e
            continue
        end
    end 
end 

function dump_all()
    ext = ".jpg"
    for user in entries
    	try
    		name = split(user["request"]["url"], "&")[3][3:14]
    		context = base64decode(user["response"]["content"]["text"])
    		for lmd in user["response"]["headers"]
    			if lmd["name"] == "last-modified"
    				println(name, " =====> ", lmd["value"])
                end
            write_context(name * ext, context)
    		end
    	catch e
    		continue
    	end
    end
end

export get_users, dump_all, init
end	# end of module
