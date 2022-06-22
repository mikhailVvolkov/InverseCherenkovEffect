%% Figure formatting
ylabel('x (um)');
xlim([-0.15 0.15]);
xlim([-0.15 0.15]);
xlim([-0.5 20]);
ylim([-50 50]);
ylim([-2000 13000]);
ylim([-10 150]);
xlabel('ps');
ylabel('x (um)');
xlabel('ps');
xlabel('ps');
ylabel('urad');
ylabel('urad');
ylabel('x - x-cm (um)');

ax = gca;
ax.Units = 'centimeters';
pos = get(ax,'pos');
ax.Position = [pos(1) pos(2) 6 6]; % hh1.Position = [p



ylim([1000*atan(-1100*15.6e-6/1.35) 1000*atan(900*15.6e-6/1.35)])
