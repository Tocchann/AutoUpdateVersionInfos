# AutoUpdateVersionInfos

Windows �f�X�N�g�b�v�A�v���̃o�[�W�����X�V�����������I�ɍs���@�\�T���v��

�O��̏o�͌��ʂ����ăo�[�W�����X�V�������Ȃ����߁A���r���h����ƃ��Z�b�g����Ă��܂��Ƃ������������邽�߁A���ǂ̗]�n�͂��邩���B

�T���v���Ƃ��āA�P���ɓ��t���o�[�W�����ɔ��f������́A��N���N�_�Ƃ��ăo�[�W������ݒ肷����́A�V���v����Revision���C���N�������g������̂̂R��ނ�p�ӁB

## �ۑ�

���r���h����ƁA���߂̃r���h��C���[�W�������邽�߁A�o�[�W���������Z�b�g����Ă��܂��Ƃ������Q������B

## ������

�r���h���ɁA@(FileVersions_) ���o�͂���悤�ɂ��Ēu���A���������r���h���Ɏ�荞�ނ悤�ɂ���ƃ��r���h���Ă��A��񂪏����Ȃ��B
�������A�N���[�����Ă��t�@�C�����폜����Ȃ��Ƃ����f�����b�g���o��(�����Ή�)

## �v���p�e�B

- `NeedSdkFileVersion`:SDK�v���W�F�N�g�`���p�o�[�W�����o�͎w��
- `NeedCppFileVersion`:C/C++ ��.rc�捞�p�o�͎w��  
$(IntDir)$(ProjectName).VersionInfo.h �ɏo�͂����̂ŁA.rc �Ŏ����Ŏ�荞�ނ���
- `NeedNetfxFileVersion`:�]���^�̃v���W�F�N�g�`���p�o�[�W�����o�͎w��B  
�����I�Ƀv���W�F�N�g�ɒǉ�����̂ŁAAssemblyInfo.cs ����o�[�W������`(`AssemblyVersion`, `AssemblyFileVersion`)���폜���Ă����K�v������B
- `AutoUpdateVersionInfo`: `BuildDate`, `OffsetDate`, `SimpleIncrement` �̂R��ނ̏o�̓p�^�[���̂����ꂩ���w��
- `StartYear`: `OffsetDate` �̏ꍇ�A��N
- `FileVersion` or `Version`: ��ƂȂ�o�[�W������ݒ�BMajor.Minor �͍Œ���ݒ肷��K�v������BC++�ȊO�͂��̃o�[�W������`AssemblyVersion`�ɂȂ�B
