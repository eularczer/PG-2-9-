function subsets = parSubsets()
    % parSubsets: 并行生成集合 A 的子集
    % depth: 控制递归深度，在前几层并行，后面串行
    A=[1,2,3,4]; depth=1;
    
    if nargin < 2
        depth = 2; % 默认前两层并行
    end
    
    if isempty(A)
        subsets = {[]};
        return;
    end
    
    if depth > 0 && numel(A) > 1
        % 并行分支
        head = A(1);
        tail = A(2:end);
        
        pool = gcp('nocreate');
        if isempty(pool)
            parpool; % 启动并行池
        end
        
        % 提交两个异步任务：
        f1 = parfeval(@parSubsets, 1, tail, depth - 1);
        f2 = parfeval(@parSubsets, 1, tail, depth - 1);
        
        % 等待结果
        tail1 = fetchOutputs(f1);
        tail2 = fetchOutputs(f2);
        
        % 组合结果（实际上 f1=f2，模拟递归的左右分支）
        subsets = [tail1, cellfun(@(x)[head, x], tail2, 'UniformOutput', false)];
    else
        % 串行递归部分
        head = A(1);
        tailSubsets = parSubsets(A(2:end), depth - 1);
        subsets = [tailSubsets, cellfun(@(x)[head, x], tailSubsets, 'UniformOutput', false)];
    end
end