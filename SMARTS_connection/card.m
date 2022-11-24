classdef (Abstract=true)card
    properties(SetAccess=protected, Hidden=false)

        flag = -1;
        no_flag = false;
        card_type = '';
        card_num = 0;
        groups = {};
        suffix = {};

    end

    methods

        function card = setCard(card, card_type, card_num, groups, suffix)
            card.card_type = card_type;
            card.card_num = card_num;
            card.groups = groups;
            card.suffix = suffix;
        end

        function param = convert2string(card, inval)
            if isstring(inval)
                param = card.(inval);
            elseif isvector(inval) & isstring(inval)
                param = [];
                temp = card.(inval);
                param = [num2str(temp(1))];
                for i = 2 : length(temp)
                    param = [param, ' ', num2str(temp(i))];
                end
            else
                param = num2str(card.(inval));
            end
        end

        function result = cardString(card)
            if isprop(card, 'amount')
                if isstring(card.amount)
                    value = card.amount;
                else
                    value = num2str(card.amount);
                end

                result = [value, char(9), ...
                     '!Card ', num2str(card.card_num), ' ', ...
                      card.card_type];

            else
                if card.no_flag
                    current = card.groups{1}{1};
                    comment = [current];
                    param = [num2str(card.(current))];
                    for i = 2 : length(card.groups{1})
                        current = card.groups{1}{i};
                        comment = [comment, ' ', current];
                        param = [param, ' ', num2str(card.(current))];
                    end

                    result = [param, char(9), '!Card ', ...
                              num2str(card.card_num), ' ', ...
                              card.card_type, ' ', comment];
                    return
                else
                    result = [num2str(card.flag), char(9), ...
                          '!Card ', num2str(card.card_num), ' ', ...
                           card.card_type];
                end
            end

            if isempty(card.card_type)
                result = [];
            end

            idx = card.flag;
            if idx > length(card.groups)
                idx = 0;
            end

            group = card.groups{idx + 1};
            if isempty(group)
                return;
            end

%            if 1 == length(group)

            if iscell(group{1})
                results = [result];

                suffix_group = card.suffix{idx+1};
                for i = 1 : length(suffix_group)
                    sub_group = group{i};
                    commentString = ['!Card ', num2str(card.card_num), ...
                                     suffix_group{i}, ' ']; 

                    paramString = [];
                    for j = 1 : length(sub_group)

                        current = sub_group{j};

                        param = card.convert2string(current);
    
                        paramString = [paramString, param];
                        commentString = [commentString, current];

                        if i < length(current)
                            paramString = [paramString, ' '];
                            commentString = [commentString, ', '];
                        end

                        temp = [paramString, char(9), commentString];

                    end
                    results = [results, newline, temp];

                end
                
                result = results;
            else
                result = [result, newline];
                paramString = [];
                commentString = ['!Card ', num2str(card.card_num), ...
                                 card.suffix{idx+1}, ' ']; 

                for i = 1 : length(group)
                    param = card.convert2string(group{i});
                    paramString = [paramString, param];
                    commentString = [commentString, group{i}];
    
                    if i < length(group)
                        paramString = [paramString, ' '];
                        commentString = [commentString, ', '];
                    end
                end

                if isempty(card.card_type)
                    result = [paramString, char(9), commentString];
                else
                    result = [result, '', paramString, char(9), commentString];
                end

            end
    


        end

    end
end
