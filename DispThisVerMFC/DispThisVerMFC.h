
// DispThisVerMFC.h : PROJECT_NAME アプリケーションのメイン ヘッダー ファイルです
//

#pragma once

#ifndef __AFXWIN_H__
	#error "PCH に対してこのファイルをインクルードする前に 'pch.h' をインクルードしてください"
#endif

#include "resource.h"		// メイン シンボル


// CDispThisVerMFCApp:
// このクラスの実装については、DispThisVerMFC.cpp を参照してください
//

class CDispThisVerMFCApp : public CWinApp
{
public:
	CDispThisVerMFCApp();

// オーバーライド
public:
	virtual BOOL InitInstance();

// 実装

	DECLARE_MESSAGE_MAP()
};

extern CDispThisVerMFCApp theApp;
