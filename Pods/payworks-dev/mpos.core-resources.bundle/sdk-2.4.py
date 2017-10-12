from subprocess import call
import os

os.chdir('displays/20x4')

call(['l10n', 'link', '11sA-J4NW-MqeCcEpxf09qtj1K5s4m50_iT0WlNq8gVo'])
call(['l10n', 'export', '--prefix', 'prompts-20x4-', '--split', '--split_prefix', 'localization', '--fallback', 'en_US'])


call(['l10n', 'link', '1gVQeruGuJaXBEpDDeCEXj6bhO5EeDVE323b9vIvgosU'])
call(['l10n', 'export', '--prefix', 'reasons-20x4-', '--split', '--split_prefix', 'localization', '--fallback', 'en_US'])


os.chdir('../40x2')

call(['l10n', 'link', '1_qLU-dgAfADWF31Aj1wxLaxYxCJox3BVfgqGh_ZpIXE'])
call(['l10n', 'export', '--prefix', 'prompts-40x2-', '--split', '--split_prefix', 'localization', '--fallback', 'en_US'])


call(['l10n', 'link', '1aq0_dHJE5ylfxbkC_pYrvboq01Ac4CA_1_S8QvN0RqE'])
call(['l10n', 'export', '--prefix', 'reasons-40x2-', '--split', '--split_prefix', 'localization', '--fallback', 'en_US'])


os.chdir('../../errors/40x1')

call(['l10n', 'link', '1kUeHGDv8i33dcJBljmO6q6yZHNMHB3GLx960P1wFGYc'])
call(['l10n', 'export', '--fallback', 'en_US', '--prefix', 'errors-40x1-', '--split', '--split_prefix', 'localization'])




