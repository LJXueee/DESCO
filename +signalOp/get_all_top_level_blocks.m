function ret = get_all_top_level_blocks(sys)
    ret = find_system(sys, 'FindAll','On','SearchDepth',2,'type','block');
end