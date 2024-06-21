--[[ finds all the nodes from the player to node (G) and endpoint to node (H)
 and then the code proceeds to sort the G value from lowest-highest and the H value from highest-lowest ]] --

local nodes = workspace.nodes:GetChildren();

local function node_find()
    for i,k in pairs(nodes) do
        table.insert(_nodes,{part = k, G = (k.Position - entity.HumanoidRootPart.Position).Magnitude});
    end

    for i,k in pairs(nodes) do
       table.insert(_target,{part = k, H = (k.Position - workspace.target.Position).Magnitude}); 
    end
    table.sort(_nodes, function(a,b)
        return a.G < b.G;
    end)
    table.sort(_target,function(a,b)
        return a.H > b.H;        
    end)

    for i,v in pairs(_nodes) do
        table.insert(F_node,_nodes[i])
    end
    for i,v in pairs(_target) do
        table.insert(F_node,_target[i])
    end
end
node_find();

--[[ Organizes the G and H values for easier calculations by splitting an array into two part
 and reorganizing the G value to be next to the H value and iterating those same values ]] --

local function path_find()
    local flow = false
    local F = {}
    local _F = {}

    for k = 0,node_amt-1 do
        for i,v in pairs(F_node) do
            if i <= node_amt then
                if flow == false then
                    table.insert(F,F_node[i+k]["G"]);
                    flow = true;
                end
            end
            if i >= node_amt+1 then
                if flow == true then
                    table.insert(F,F_node[i+k]["H"]);
                    flow = false;
                end
            end
        end
    end

    for i = 1,node_amt*2,2 do
        table.insert(_F,math.round(F[i]+F[i+1]))
    end

    for i = 1,node_amt do
        _nodes[i].G = _F[i];
    end

    table.sort(_nodes, function(a,b)
        return a.G < b.G
    end)
end
path_find();

print(_nodes)

-- this was supposed to a function to draw a line and later check for any intersection (unfortunately I was on a huge time crunch from having to deal with exams and school projects)
-- so I only have the basic part and calculations done

local target_draw_line = {}
local entity_draw_line = {}

for i=1,node_amt-1 do
    local cent = (_nodes[i]["part"].Position + _nodes[i+1]["part"].Position)/2
    local arrow = Instance.new("Part");
        arrow.Anchored = true
        arrow.Parent = workspace
        arrow.CanCollide = false
        arrow.Name = "line"
        arrow.CFrame = CFrame.lookAt(cent,_nodes[i]["part"].Position)
        arrow.Size = Vector3.new(1,0.5,(_nodes[i]["part"].Position - _nodes[i+1]["part"].Position).Magnitude)
end

for i=1,node_amt-1 do
    if i==node_amt then
        local cent = (_nodes[i]["part"].Position + entity.HumanoidRootPart.Position)/2
        local arrow = Instance.new("Part");
        arrow.Anchored = true
        arrow.Parent = workspace
        arrow.CanCollide = false
        arrow.Name = "line_entity"
        arrow.CFrame = CFrame.lookAt(cent,_nodes[i]["part"].Position)
        arrow.Size = Vector3.new(1,0.5,(_nodes[i]["part"].Position - entity.HumanoidRootPart.Position).Magnitude)
    end
    if i==node_amt+1 then
        local cent = (_nodes[i]["part"].Position + workspace.target.Position)/2
        local arrow = Instance.new("Part");
        arrow.Anchored = true
        arrow.Parent = workspace
        arrow.CanCollide = false
        arrow.Name = "line_entity"
        arrow.CFrame = CFrame.lookAt(cent,_nodes[i]["part"].Position)
        arrow.Size = Vector3.new(1,0.5,(_nodes[i]["part"].Position - workspace.target.Position).Magnitude)
    end
end

for i,k in pairs(nodes) do
    table.insert(entity_draw_line,(k.Position - entity.HumanoidRootPart.Position).Magnitude)
    table.sort(entity_draw_line,function(a,b)
        return a < b
    end)
    print(entity_draw_line)
end
