;
; Modified Ripe Mainloop from SecureCRT
;
		sub	esp, 58h
		mov	edx, [esp+58h]
		push	ebx
		push	ebp
		push	esi
		mov	esi, [esp+68h]
		push	edi
		mov	ecx, 10h
		lea	edi, [esp+64h-40h]
		mov	eax, [edx+4]
		repz	movsd
		mov	esi, [edx+0Ch]
		mov	ecx, [edx]
		mov	edi, [edx+8]
		mov	edx, [edx+10h]
		mov	ebp, esi
		mov	ebx, ecx
		xor	ebp, edi
		mov	[esp+64h+8], edi
		rol	ebx, 5
		and	ebp, eax
		add	edx, ebx
		xor	ebp, esi
		add	ebp, edx
		mov	edx, [esp+64h-40h]
		rol	eax, 1Eh
		lea	edx, [edx+ebp+5A827999h]
		mov	ebp, edi
		xor	ebp, eax
		mov	ebx, edx
		and	ebp, ecx
		xor	ebp, edi
		mov	edi, [esp+64h-3Ch]
		rol	ebx, 5
		add	edi, ebx
		mov	ebx, eax
		add	ebp, edi
		rol	ecx, 1Eh
		lea	esi, [esi+ebp+5A827999h]
		mov	ebp, [esp+64h-38h]
		mov	edi, esi
		xor	ebx, ecx
		rol	edi, 5
		and	ebx, edx
		add	ebp, edi
		mov	edi, [esp+64h+8]
		xor	ebx, eax
		add	ebx, ebp
		mov	ebp, [esp+64h-34h]
		rol	edx, 1Eh
		lea	edi, [edi+ebx+5A827999h]
		mov	[esp+64h+8], edx
		mov	ebx, edi
		xor	edx, ecx
		rol	ebx, 5
		and	edx, esi
		add	ebp, ebx
		xor	edx, ecx
		add	edx, ebp
		rol	esi, 1Eh
		lea	eax, [eax+edx+5A827999h]
		mov	edx, [esp+64h+8]
		mov	ebp, edx
		mov	ebx, eax
		xor	ebp, esi
		and	ebp, edi
		xor	ebp, edx
		mov	edx, [esp+64h-30h]
		rol	ebx, 5
		add	edx, ebx
		mov	ebx, esi
		add	ebp, edx
		rol	edi, 1Eh
		lea	ecx, [ecx+ebp+5A827999h]
		mov	ebp, [esp+64h-2Ch]
		mov	edx, ecx
		xor	ebx, edi
		rol	edx, 5
		and	ebx, eax
		add	ebp, edx
		xor	ebx, esi
		add	ebx, ebp
		mov	edx, [esp+64h+8]
		mov	ebp, edi
		rol	eax, 1Eh
		lea	edx, [edx+ebx+5A827999h]
		xor	ebp, eax
		mov	ebx, edx
		mov	[esp+64h-50h], eax
		mov	eax, [esp+64h-28h]
		and	ebp, ecx
		rol	ebx, 5
		xor	ebp, edi
		add	eax, ebx
		add	ebp, eax
		mov	eax, [esp+64h-50h]
		rol	ecx, 1Eh
		lea	esi, [esi+ebp+5A827999h]
		mov	ebp, eax
		xor	ebp, ecx
		mov	ebx, esi
		and	ebp, edx
		xor	ebp, eax
		mov	eax, [esp+64h-24h]
		rol	ebx, 5
		add	eax, ebx
		add	ebp, eax
		rol	edx, 1Eh
		lea	edi, [edi+ebp+5A827999h]
		mov	ebp, [esp+64h-20h]
		mov	ebx, edx
		mov	eax, edi
		xor	ebx, ecx
		rol	eax, 5
		and	ebx, esi
		add	ebp, eax
		mov	eax, [esp+64h-50h]
		xor	ebx, ecx
		add	ebx, ebp
		mov	ebp, edx
		rol	esi, 1Eh
		lea	eax, [eax+ebx+5A827999h]
		xor	ebp, esi
		mov	ebx, eax
		mov	[esp+64h-4Ch], esi
		mov	esi, [esp+64h-1Ch]
		and	ebp, edi
		rol	ebx, 5
		xor	ebp, edx
		add	esi, ebx
		add	ebp, esi
		mov	esi, [esp+64h-4Ch]
		rol	edi, 1Eh
		lea	ecx, [ecx+ebp+5A827999h]
		mov	ebp, esi
		xor	ebp, edi
		mov	ebx, ecx
		and	ebp, eax
		xor	ebp, esi
		mov	esi, [esp+64h-18h]
		rol	ebx, 5
		add	esi, ebx
		mov	ebx, edi
		add	ebp, esi
		rol	eax, 1Eh
		lea	edx, [edx+ebp+5A827999h]
		mov	ebp, [esp+64h-14h]
		mov	esi, edx
		xor	ebx, eax
		rol	esi, 5
		and	ebx, ecx
		add	ebp, esi
		mov	esi, [esp+64h-4Ch]
		xor	ebx, edi
		add	ebx, ebp
		mov	ebp, eax
		rol	ecx, 1Eh
		lea	ebx, [esi+ebx+5A827999h]
		xor	ebp, ecx
		mov	esi, ebx
		mov	[esp+64h-54h], ecx
		rol	esi, 5
		and	ebp, edx
		mov	ecx, [esp+64h-10h]
		xor	ebp, eax
		add	ecx, esi
		add	ebp, ecx
		mov	ecx, [esp+64h-54h]
		rol	edx, 1Eh
		lea	edi, [edi+ebp+5A827999h]
		mov	ebp, edx
		xor	ebp, ecx
		mov	esi, edi
		and	ebp, ebx
		xor	ebp, ecx
		mov	ecx, [esp+64h-0Ch]
		rol	esi, 5
		add	ecx, esi
		mov	esi, edx
		add	ebp, ecx
		rol	ebx, 1Eh
		lea	eax, [eax+ebp+5A827999h]
		mov	ebp, [esp+64h-08h]
		mov	ecx, eax
		xor	esi, ebx
		rol	ecx, 5
		and	esi, edi
		add	ebp, ecx
		mov	ecx, [esp+64h-54h]
		xor	esi, edx
		add	esi, ebp
		mov	ebp, ebx
		rol	edi, 1Eh
		lea	ecx, [ecx+esi+5A827999h]
		xor	ebp, edi
		mov	esi, ecx
		mov	[esp+64h-48h], edi
		mov	edi, [esp+64h-04h]
		and	ebp, eax
		rol	esi, 5
		xor	ebp, ebx
		add	edi, esi
		add	ebp, edi
		mov	edi, [esp+64h-38h]
		rol	eax, 1Eh
		lea	edx, [edx+ebp+5A827999h]
		mov	ebp, [esp+64h-20h]
		mov	esi, eax
		mov	eax, [esp+64h-0Ch]
		xor	eax, ebp
		mov	ebp, [esp+64h-40h]
		xor	eax, edi
		mov	[esp+64h-50h], esi
		xor	eax, ebp
		mov	ebp, [esp+64h-48h]
		xor	ebp, esi
		mov	esi, [esp+64h-48h]
		and	ebp, ecx
		mov	edi, edx
		rol	eax, 1
		xor	ebp, esi
		mov	esi, eax
		rol	edi, 5
		add	esi, edi
		mov	edi, [esp+64h-34h]
		add	ebp, esi
		rol	ecx, 1Eh
		lea	ebx, [ebx+ebp+5A827999h]
		mov	ebp, [esp+64h-1Ch]
		mov	esi, ecx
		mov	ecx, [esp+64h-08h]
		xor	ecx, ebp
		mov	ebp, [esp+64h-3Ch]
		xor	ecx, edi
		mov	[esp+64h-54h], esi
		xor	ecx, ebp
		mov	ebp, [esp+64h-50h]
		xor	ebp, esi
		mov	esi, [esp+64h-50h]
		mov	edi, ebx
		and	ebp, edx
		rol	ecx, 1
		rol	edi, 5
		xor	ebp, esi
		mov	esi, ecx
		add	esi, edi
		add	ebp, esi
		mov	esi, [esp+64h-48h]
		rol	edx, 1Eh
		lea	edi, [esi+ebp+5A827999h]
		mov	ebp, [esp+64h-18h]
		mov	esi, edx
		mov	edx, [esp+64h-04h]
		xor	edx, ebp
		mov	ebp, [esp+64h-30h]
		xor	edx, ebp
		mov	ebp, [esp+64h-38h]
		xor	edx, ebp
		mov	[esp+64h+8], esi
		mov	ebp, esi
		mov	esi, [esp+64h-54h]
		xor	ebp, esi
		mov	[esp+64h-48h], edi
		and	ebp, ebx
		rol	edx, 1
		xor	ebp, esi
		mov	esi, edx
		rol	edi, 5
		add	esi, edi
		add	ebp, esi
		mov	esi, [esp+64h-50h]
		rol	ebx, 1Eh
		lea	edi, [esi+ebp+5A827999h]
		mov	esi, [esp+64h-14h]
		mov	ebp, [esp+64h-2Ch]
		mov	[esp+64h-4Ch], ebx
		xor	esi, ebp
		mov	ebp, [esp+64h-34h]
		xor	esi, ebp
		mov	ebp, [esp+64h+8]
		xor	ebp, ebx
		mov	ebx, [esp+64h-48h]
		xor	esi, eax
		and	ebp, ebx
		mov	ebx, [esp+64h+8]
		mov	[esp+64h-50h], edi
		rol	esi, 1
		xor	ebp, ebx
		mov	ebx, esi
		rol	edi, 5
		add	ebx, edi
		mov	edi, [esp+64h-54h]
		add	ebp, ebx
		lea	ebx, [edi+ebp+5A827999h]
		mov	edi, [esp+64h-48h]
		rol	edi, 1Eh
		mov	ebp, edi
		mov	edi, [esp+64h-10h]
		xor	edi, [esp+64h-28h]
		mov	[esp+64h-48h], ebp
		mov	[esp+64h-54h], ebx
		xor	edi, [esp+64h-30h]
		xor	edi, ecx
		rol	edi, 1
		mov	[esp+64h-30h], edi
		mov	edi, [esp+64h-4Ch]
		xor	edi, ebp
		mov	ebp, [esp+64h-50h]
		xor	edi, ebp
		mov	ebp, [esp+64h-30h]
		rol	ebx, 5
		add	ebp, ebx
		mov	ebx, [esp+64h+8]
		add	edi, ebp
		lea	ebx, [ebx+edi+6ED9EBA1h]
		mov	edi, [esp+64h-50h]
		rol	edi, 1Eh
		mov	ebp, edi
		mov	edi, [esp+64h-0Ch]
		xor	edi, [esp+64h-24h]
		mov	[esp+64h+8], ebx
		mov	[esp+64h-50h], ebp
		xor	edi, [esp+64h-2Ch]
		xor	edi, edx
		rol	edi, 1
		mov	[esp+64h-2Ch], edi
		mov	edi, [esp+64h-48h]
		xor	edi, ebp
		mov	ebp, [esp+64h-54h]
		xor	edi, ebp
		mov	ebp, [esp+64h-2Ch]
		rol	ebx, 5
		add	ebp, ebx
		mov	ebx, [esp+64h-4Ch]
		add	edi, ebp
		mov	ebp, [esp+64h-20h]
		lea	ebx, [ebx+edi+6ED9EBA1h]
		mov	edi, [esp+64h-54h]
		rol	edi, 1Eh
		mov	[esp+64h-54h], edi
		mov	edi, [esp+64h-08h]
		xor	edi, ebp
		mov	ebp, [esp+64h-28h]
		xor	edi, ebp
		mov	ebp, [esp+64h-50h]
		xor	edi, esi
		mov	[esp+64h-4Ch], ebx
		rol	edi, 1
		mov	[esp+64h-28h], edi
		mov	edi, [esp+64h+8]
		xor	edi, ebp
		mov	ebp, [esp+64h-54h]
		xor	edi, ebp
		mov	ebp, [esp+64h-28h]
		rol	ebx, 5
		add	ebp, ebx
		mov	ebx, [esp+64h-48h]
		add	edi, ebp
		lea	ebx, [ebx+edi+6ED9EBA1h]
		mov	edi, [esp+64h+8]
		rol	edi, 1Eh
		mov	ebp, edi
		mov	edi, [esp+64h-04h]
		xor	edi, [esp+64h-1Ch]
		mov	[esp+64h+8], ebp
		mov	[esp+64h-48h], ebx
		xor	edi, [esp+64h-24h]
		xor	edi, [esp+64h-30h]
		rol	edi, 1
		mov	[esp+64h-24h], edi
		mov	edi, [esp+64h-4Ch]
		xor	ebp, edi
		mov	edi, [esp+64h-54h]
		xor	ebp, edi
		mov	edi, [esp+64h-24h]
		rol	ebx, 5
		add	edi, ebx
		add	ebp, edi
		mov	edi, [esp+64h-50h]
		lea	ebx, [edi+ebp+6ED9EBA1h]
		mov	edi, [esp+64h-4Ch]
		rol	edi, 1Eh
		mov	ebp, edi
		mov	edi, [esp+64h-18h]
		xor	edi, [esp+64h-20h]
		mov	[esp+64h-4Ch], ebp
		mov	[esp+64h-50h], ebx
		xor	edi, [esp+64h-2Ch]
		xor	edi, eax
		rol	edi, 1
		mov	[esp+64h-20h], edi
		mov	edi, [esp+64h+8]
		xor	edi, ebp
		mov	ebp, [esp+64h-48h]
		xor	edi, ebp
		mov	ebp, [esp+64h-20h]
		rol	ebx, 5
		add	ebp, ebx
		mov	ebx, [esp+64h-54h]
		add	edi, ebp
		lea	ebx, [ebx+edi+6ED9EBA1h]
		mov	edi, [esp+64h-48h]
		rol	edi, 1Eh
		mov	ebp, edi
		mov	[esp+64h-54h], ebx
		mov	[esp+64h-48h], ebp
		mov	edi, [esp+64h-14h]
		xor	edi, [esp+64h-1Ch]
		xor	edi, [esp+64h-28h]
		xor	edi, ecx
		rol	edi, 1
		mov	[esp+64h-1Ch], edi
		mov	edi, [esp+64h-4Ch]
		xor	edi, ebp
		mov	ebp, [esp+64h-50h]
		xor	edi, ebp
		mov	ebp, [esp+64h-1Ch]
		rol	ebx, 5
		add	ebp, ebx
		mov	ebx, [esp+64h+8]
		add	edi, ebp
		lea	ebx, [ebx+edi+6ED9EBA1h]
		mov	edi, [esp+64h-50h]
		rol	edi, 1Eh
		mov	ebp, edi
		mov	edi, [esp+64h-10h]
		xor	edi, [esp+64h-18h]
		mov	[esp+64h-50h], ebp
		mov	[esp+64h+8], ebx
		xor	edi, [esp+64h-24h]
		xor	edi, edx
		rol	edi, 1
		mov	[esp+64h-18h], edi
		mov	edi, [esp+64h-48h]
		xor	edi, ebp
		mov	ebp, [esp+64h-54h]
		xor	edi, ebp
		mov	ebp, [esp+64h-18h]
		rol	ebx, 5
		add	ebp, ebx
		mov	ebx, [esp+64h-4Ch]
		add	edi, ebp
		mov	ebp, [esp+64h-14h]
		lea	ebx, [ebx+edi+6ED9EBA1h]
		mov	edi, [esp+64h-54h]
		rol	edi, 1Eh
		mov	[esp+64h-54h], edi
		mov	edi, [esp+64h-0Ch]
		xor	edi, ebp
		mov	ebp, [esp+64h-20h]
		xor	edi, ebp
		mov	ebp, [esp+64h-50h]
		xor	edi, esi
		mov	[esp+64h-4Ch], ebx
		rol	edi, 1
		mov	[esp+64h-14h], edi
		mov	edi, [esp+64h+8]
		xor	edi, ebp
		mov	ebp, [esp+64h-54h]
		xor	edi, ebp
		mov	ebp, [esp+64h-14h]
		rol	ebx, 5
		add	ebp, ebx
		mov	ebx, [esp+64h-48h]
		add	edi, ebp
		lea	ebx, [ebx+edi+6ED9EBA1h]
		mov	edi, [esp+64h+8]
		rol	edi, 1Eh
		mov	ebp, edi
		mov	edi, [esp+64h-08h]
		xor	edi, [esp+64h-10h]
		mov	[esp+64h+8], ebp
		mov	[esp+64h-48h], ebx
		xor	edi, [esp+64h-1Ch]
		xor	edi, [esp+64h-30h]
		rol	edi, 1
		mov	[esp+64h-10h], edi
		mov	edi, [esp+64h-4Ch]
		xor	ebp, edi
		mov	edi, [esp+64h-54h]
		xor	ebp, edi
		mov	edi, [esp+64h-10h]
		rol	ebx, 5
		add	edi, ebx
		add	ebp, edi
		mov	edi, [esp+64h-50h]
		lea	ebx, [edi+ebp+6ED9EBA1h]
		mov	edi, [esp+64h-4Ch]
		mov	[esp+64h-50h], ebx
		rol	edi, 1Eh
		mov	ebp, edi
		mov	edi, [esp+64h-04h]
		xor	edi, [esp+64h-0Ch]
		mov	[esp+64h-4Ch], ebp
		xor	edi, [esp+64h-18h]
		xor	edi, [esp+64h-2Ch]
		rol	edi, 1
		mov	[esp+64h-0Ch], edi
		mov	edi, [esp+64h+8]
		xor	edi, ebp
		mov	ebp, [esp+64h-48h]
		xor	edi, ebp
		mov	ebp, [esp+64h-0Ch]
		rol	ebx, 5
		add	ebp, ebx
		mov	ebx, [esp+64h-54h]
		add	edi, ebp
		lea	ebx, [ebx+edi+6ED9EBA1h]
		mov	edi, [esp+64h-48h]
		rol	edi, 1Eh
		mov	ebp, edi
		mov	edi, [esp+64h-08h]
		xor	edi, [esp+64h-14h]
		mov	[esp+64h-48h], ebp
		mov	[esp+64h-54h], ebx
		xor	edi, [esp+64h-28h]
		xor	edi, eax
		rol	edi, 1
		mov	[esp+64h-08h], edi
		mov	edi, [esp+64h-4Ch]
		xor	edi, ebp
		mov	ebp, [esp+64h-50h]
		xor	edi, ebp
		mov	ebp, [esp+64h-08h]
		rol	ebx, 5
		add	ebp, ebx
		mov	ebx, [esp+64h+8]
		add	edi, ebp
		lea	ebx, [ebx+edi+6ED9EBA1h]
		mov	edi, [esp+64h-50h]
		rol	edi, 1Eh
		mov	ebp, edi
		mov	edi, [esp+64h-04h]
		xor	edi, [esp+64h-10h]
		mov	[esp+64h-50h], ebp
		mov	[esp+64h+8], ebx
		xor	edi, [esp+64h-24h]
		xor	edi, ecx
		rol	edi, 1
		mov	[esp+64h-04h], edi
		mov	edi, [esp+64h-48h]
		xor	edi, ebp
		mov	ebp, [esp+64h-54h]
		xor	edi, ebp
		mov	ebp, [esp+64h-04h]
		rol	ebx, 5
		add	ebp, ebx
		mov	ebx, [esp+64h-4Ch]
		add	edi, ebp
		mov	ebp, [esp+64h-20h]
		lea	ebx, [ebx+edi+6ED9EBA1h]
		mov	edi, [esp+64h-54h]
		rol	edi, 1Eh
		mov	[esp+64h-54h], edi
		mov	edi, [esp+64h-0Ch]
		xor	edi, ebp
		mov	ebp, [esp+64h-50h]
		xor	edi, edx
		mov	[esp+64h-4Ch], ebx
		xor	edi, eax
		mov	eax, [esp+64h+8]
		xor	eax, ebp
		mov	ebp, [esp+64h-54h]
		rol	edi, 1
		xor	eax, ebp
		mov	ebp, edi
		rol	ebx, 5
		add	ebp, ebx
		mov	ebx, [esp+64h-48h]
		add	eax, ebp
		lea	ebx, [ebx+eax+6ED9EBA1h]
		mov	eax, [esp+64h+8]
		rol	eax, 1Eh
		mov	ebp, eax
		mov	eax, [esp+64h-08h]
		xor	eax, [esp+64h-1Ch]
		mov	[esp+64h+8], ebp
		mov	[esp+64h-48h], ebx
		xor	eax, esi
		xor	eax, ecx
		mov	ecx, [esp+64h-4Ch]
		xor	ebp, ecx
		mov	ecx, [esp+64h-54h]
		rol	eax, 1
		xor	ebp, ecx
		mov	ecx, eax
		rol	ebx, 5
		add	ecx, ebx
		add	ebp, ecx
		mov	ecx, [esp+64h-50h]
		lea	ebx, [ecx+ebp+6ED9EBA1h]
		mov	ecx, [esp+64h-4Ch]
		rol	ecx, 1Eh
		mov	ebp, ecx
		mov	ecx, [esp+64h-04h]
		xor	ecx, [esp+64h-18h]
		mov	[esp+64h-4Ch], ebp
		mov	[esp+64h-50h], ebx
		xor	ecx, [esp+64h-30h]
		xor	ecx, edx
		mov	edx, [esp+64h+8]
		xor	edx, ebp
		mov	ebp, [esp+64h-48h]
		rol	ecx, 1
		xor	edx, ebp
		mov	ebp, ecx
		rol	ebx, 5
		add	ebp, ebx
		mov	ebx, [esp+64h-54h]
		add	edx, ebp
		lea	ebp, [ebx+edx+6ED9EBA1h]
		mov	edx, [esp+64h-14h]
		xor	edx, [esp+64h-2Ch]
		mov	ebx, [esp+64h-48h]
		rol	ebx, 1Eh
		xor	edx, esi
		mov	esi, [esp+64h-4Ch]
		xor	edx, edi
		mov	[esp+64h-54h], ebp
		rol	edx, 1
		xor	esi, ebx
		mov	[esp+64h-34h], edx
		xor	esi, [esp+64h-50h]
		mov	[esp+64h-48h], ebx
		rol	ebp, 5
		add	edx, ebp
		add	esi, edx
		mov	edx, [esp+64h+8]
		lea	esi, [edx+esi+6ED9EBA1h]
		mov	edx, [esp+64h-50h]
		rol	edx, 1Eh
		mov	ebp, edx
		mov	edx, [esp+64h-10h]
		xor	edx, [esp+64h-28h]
		mov	[esp+64h-50h], ebp
		xor	ebx, ebp
		mov	ebp, [esp+64h-54h]
		xor	edx, [esp+64h-30h]
		mov	[esp+64h+8], esi
		xor	ebx, ebp
		xor	edx, eax
		rol	edx, 1
		rol	esi, 5
		mov	ebp, edx
		mov	[esp+64h-30h], edx
		add	ebp, esi
		mov	esi, [esp+64h-4Ch]
		add	ebx, ebp
		lea	ebx, [esi+ebx+6ED9EBA1h]
		mov	esi, [esp+64h-54h]
		mov	ebp, [esp+64h-24h]
		rol	esi, 1Eh
		mov	[esp+64h-54h], esi
		mov	esi, [esp+64h-0Ch]
		xor	esi, ebp
		mov	ebp, [esp+64h-2Ch]
		xor	esi, ebp
		mov	ebp, [esp+64h-50h]
		xor	esi, ecx
		mov	[esp+64h-4Ch], ebx
		rol	esi, 1
		mov	[esp+64h-2Ch], esi
		mov	esi, [esp+64h+8]
		xor	esi, ebp
		mov	ebp, [esp+64h-54h]
		xor	esi, ebp
		mov	ebp, [esp+64h-2Ch]
		rol	ebx, 5
		add	ebp, ebx
		mov	ebx, [esp+64h-48h]
		add	esi, ebp
		lea	ebx, [ebx+esi+6ED9EBA1h]
		mov	esi, [esp+64h+8]
		rol	esi, 1Eh
		mov	ebp, esi
		mov	esi, [esp+64h-08h]
		xor	esi, [esp+64h-20h]
		mov	[esp+64h+8], ebp
		mov	[esp+64h-48h], ebx
		xor	esi, [esp+64h-28h]
		xor	esi, [esp+64h-34h]
		rol	esi, 1
		mov	[esp+64h-28h], esi
		mov	esi, [esp+64h-4Ch]
		xor	ebp, esi
		mov	esi, [esp+64h-54h]
		xor	ebp, esi
		mov	esi, [esp+64h-28h]
		rol	ebx, 5
		add	esi, ebx
		add	ebp, esi
		mov	esi, [esp+64h-50h]
		lea	ebx, [esi+ebp+6ED9EBA1h]
		mov	esi, [esp+64h-4Ch]
		rol	esi, 1Eh
		mov	ebp, esi
		mov	esi, [esp+64h-04h]
		xor	esi, [esp+64h-1Ch]
		mov	[esp+64h-50h], ebx
		mov	[esp+64h-4Ch], ebp
		xor	esi, [esp+64h-24h]
		xor	esi, edx
		mov	edx, [esp+64h-48h]
		rol	esi, 1
		rol	ebx, 5
		mov	[esp+64h-44h], ebx
		mov	ebx, [esp+64h+8]
		xor	ebx, ebp
		mov	ebp, [esp+64h-44h]
		mov	[esp+64h-24h], esi
		xor	ebx, edx
		add	esi, ebp
		mov	ebp, [esp+64h-20h]
		add	ebx, esi
		mov	esi, [esp+64h-54h]
		rol	edx, 1Eh
		lea	ebx, [esi+ebx+6ED9EBA1h]
		mov	esi, edx
		mov	edx, [esp+64h-18h]
		mov	[esp+64h-54h], ebx
		xor	edx, ebp
		mov	ebp, [esp+64h-2Ch]
		xor	edx, ebp
		mov	[esp+64h-48h], esi
		xor	edx, edi
		mov	ebp, esi
		rol	edx, 1
		mov	[esp+64h-20h], edx
		mov	edx, [esp+64h-50h]
		rol	ebx, 5
		or	ebp, edx
		and	esi, edx
		and	ebp, [esp+64h-4Ch]
		or	ebp, esi
		mov	esi, [esp+64h-20h]
		add	ebp, esi
		mov	esi, [esp+64h+8]
		add	ebp, esi
		rol	edx, 1Eh
		lea	ebx, [ebx+ebp-70E44324h]
		mov	ebp, [esp+64h-1Ch]
		mov	esi, edx
		mov	edx, [esp+64h-14h]
		xor	edx, ebp
		mov	ebp, [esp+64h-28h]
		xor	edx, ebp
		mov	ebp, esi
		xor	edx, eax
		mov	[esp+64h-50h], esi
		rol	edx, 1
		mov	[esp+64h-1Ch], edx
		mov	edx, [esp+64h-54h]
		or	ebp, edx
		and	esi, edx
		and	ebp, [esp+64h-48h]
		mov	[esp+64h+8], ebx
		rol	ebx, 5
		or	ebp, esi
		mov	esi, [esp+64h-1Ch]
		add	ebp, esi
		mov	esi, [esp+64h-4Ch]
		add	ebp, esi
		rol	edx, 1Eh
		lea	ebx, [ebx+ebp-70E44324h]
		mov	ebp, [esp+64h-18h]
		mov	esi, edx
		mov	edx, [esp+64h-10h]
		xor	edx, ebp
		mov	ebp, [esp+64h-24h]
		xor	edx, ebp
		mov	[esp+64h-54h], esi
		xor	edx, ecx
		mov	[esp+64h-4Ch], ebx
		rol	edx, 1
		mov	[esp+64h-18h], edx
		mov	edx, [esp+64h+8]
		mov	ebp, edx
		and	edx, esi
		or	ebp, esi
		mov	esi, [esp+64h-18h]
		and	ebp, [esp+64h-50h]
		rol	ebx, 5
		or	ebp, edx
		mov	edx, [esp+64h-48h]
		add	ebp, esi
		add	ebp, edx
		mov	edx, [esp+64h+8]
		rol	edx, 1Eh
		lea	ebx, [ebx+ebp-70E44324h]
		mov	ebp, [esp+64h-14h]
		mov	esi, edx
		mov	edx, [esp+64h-0Ch]
		xor	edx, ebp
		mov	ebp, [esp+64h-20h]
		xor	edx, ebp
		mov	ebp, [esp+64h-34h]
		xor	edx, ebp
		mov	ebp, esi
		rol	edx, 1
		mov	[esp+64h-14h], edx
		mov	edx, [esp+64h-4Ch]
		or	ebp, edx
		mov	[esp+64h+8], esi
		and	ebp, [esp+64h-54h]
		and	esi, edx
		mov	[esp+64h-48h], ebx
		or	ebp, esi
		mov	esi, [esp+64h-14h]
		rol	ebx, 5
		add	ebp, esi
		mov	esi, [esp+64h-50h]
		add	ebp, esi
		rol	edx, 1Eh
		lea	ebx, [ebx+ebp-70E44324h]
		mov	ebp, [esp+64h-10h]
		mov	esi, edx
		mov	edx, [esp+64h-08h]
		xor	edx, ebp
		mov	ebp, [esp+64h-1Ch]
		xor	edx, ebp
		mov	ebp, [esp+64h-30h]
		xor	edx, ebp
		mov	ebp, esi
		rol	edx, 1
		mov	[esp+64h-10h], edx
		mov	edx, [esp+64h-48h]
		or	ebp, edx
		mov	[esp+64h-4Ch], esi
		and	ebp, [esp+64h+8]
		and	esi, edx
		mov	[esp+64h-50h], ebx
		or	ebp, esi
		mov	esi, [esp+64h-10h]
		add	ebp, esi
		mov	esi, [esp+64h-54h]
		add	ebp, esi
		rol	ebx, 5
		rol	edx, 1Eh
		lea	ebx, [ebx+ebp-70E44324h]
		mov	ebp, [esp+64h-0Ch]
		mov	esi, edx
		mov	edx, [esp+64h-04h]
		xor	edx, ebp
		mov	ebp, [esp+64h-18h]
		xor	edx, ebp
		mov	ebp, [esp+64h-2Ch]
		xor	edx, ebp
		mov	ebp, esi
		rol	edx, 1
		mov	[esp+64h-0Ch], edx
		mov	edx, [esp+64h-50h]
		or	ebp, edx
		mov	[esp+64h-48h], esi
		and	ebp, [esp+64h-4Ch]
		and	esi, edx
		mov	[esp+64h-54h], ebx
		or	ebp, esi
		mov	esi, [esp+64h-0Ch]
		add	ebp, esi
		mov	esi, [esp+64h+8]
		rol	ebx, 5
		add	ebp, esi
		rol	edx, 1Eh
		lea	ebx, [ebx+ebp-70E44324h]
		mov	ebp, [esp+64h-14h]
		mov	esi, edx
		mov	edx, [esp+64h-08h]
		xor	edx, ebp
		mov	ebp, [esp+64h-28h]
		xor	edx, ebp
		mov	ebp, esi
		xor	edx, edi
		mov	[esp+64h-50h], esi
		rol	edx, 1
		mov	[esp+64h-08h], edx
		mov	edx, [esp+64h-54h]
		or	ebp, edx
		and	esi, edx
		and	ebp, [esp+64h-48h]
		mov	[esp+64h+8], ebx
		rol	ebx, 5
		or	ebp, esi
		mov	esi, [esp+64h-08h]
		add	ebp, esi
		mov	esi, [esp+64h-4Ch]
		add	ebp, esi
		rol	edx, 1Eh
		lea	esi, [ebx+ebp-70E44324h]
		mov	ebx, edx
		mov	edx, [esp+64h-04h]
		mov	[esp+64h-4Ch], esi
		mov	[esp+64h-54h], ebx
		mov	ebp, [esp+64h-10h]
		xor	edx, ebp
		mov	ebp, [esp+64h-24h]
		xor	edx, ebp
		xor	edx, eax
		rol	edx, 1
		mov	[esp+64h-04h], edx
		mov	edx, [esp+64h+8]
		mov	ebp, edx
		and	edx, ebx
		or	ebp, ebx
		and	ebp, [esp+64h-50h]
		rol	esi, 5
		or	ebp, edx
		mov	edx, [esp+64h-04h]
		add	ebp, edx
		add	ebp, [esp+64h-48h]
		lea	ebp, [esi+ebp-70E44324h]
		mov	esi, [esp+64h+8]
		rol	esi, 1Eh
		mov	[esp+64h+8], esi
		mov	esi, [esp+64h-0Ch]
		xor	esi, [esp+64h-20h]
		mov	[esp+64h-48h], ebp
		xor	esi, ecx
		xor	esi, edi
		mov	edi, [esp+64h+8]
		or	edi, [esp+64h-4Ch]
		rol	esi, 1
		and	edi, ebx
		mov	ebx, [esp+64h+8]
		and	ebx, [esp+64h-4Ch]
		rol	ebp, 5
		or	edi, ebx
		mov	ebx, [esp+64h-50h]
		add	edi, esi
		add	edi, ebx
		mov	ebx, [esp+64h-4Ch]
		rol	ebx, 1Eh
		lea	ebp, [edi+ebp-70E44324h]
		mov	edi, [esp+64h-08h]
		xor	edi, [esp+64h-1Ch]
		mov	[esp+64h-4Ch], ebx
		mov	[esp+64h-50h], ebp
		xor	edi, [esp+64h-34h]
		xor	edi, eax
		mov	eax, [esp+64h-48h]
		rol	edi, 1
		mov	[esp+64h-3Ch], edi
		mov	edi, ebx
		or	edi, eax
		and	ebx, eax
		and	edi, [esp+64h+8]
		rol	ebp, 5
		or	edi, ebx
		mov	ebx, [esp+64h-3Ch]
		add	edi, ebx
		mov	ebx, [esp+64h-54h]
		add	edi, ebx
		rol	eax, 1Eh
		lea	ebx, [edi+ebp-70E44324h]
		mov	ebp, [esp+64h-18h]
		mov	edi, eax
		mov	eax, edx
		xor	eax, ebp
		mov	ebp, [esp+64h-30h]
		xor	eax, ebp
		mov	ebp, edi
		xor	eax, ecx
		mov	ecx, [esp+64h-50h]
		or	ebp, ecx
		mov	[esp+64h-48h], edi
		and	ebp, [esp+64h-4Ch]
		and	edi, ecx
		rol	eax, 1
		or	ebp, edi
		mov	edi, [esp+64h+8]
		mov	[esp+64h-54h], ebx
		add	ebp, eax
		rol	ebx, 5
		add	ebp, edi
		rol	ecx, 1Eh
		lea	ebx, [ebx+ebp-70E44324h]
		mov	ebp, [esp+64h-2Ch]
		mov	edi, ecx
		mov	ecx, [esp+64h-14h]
		xor	ecx, ebp
		mov	ebp, [esp+64h-34h]
		xor	ecx, ebp
		mov	ebp, edi
		xor	ecx, esi
		mov	[esp+64h-50h], edi
		rol	ecx, 1
		mov	[esp+64h-34h], ecx
		mov	ecx, [esp+64h-54h]
		or	ebp, ecx
		and	edi, ecx
		and	ebp, [esp+64h-48h]
		mov	[esp+64h+8], ebx
		rol	ebx, 5
		or	ebp, edi
		mov	edi, [esp+64h-34h]
		add	ebp, edi
		mov	edi, [esp+64h-4Ch]
		add	ebp, edi
		rol	ecx, 1Eh
		lea	ebx, [ebx+ebp-70E44324h]
		mov	ebp, [esp+64h-28h]
		mov	edi, ecx
		mov	ecx, [esp+64h-10h]
		xor	ecx, ebp
		mov	ebp, [esp+64h-30h]
		xor	ecx, ebp
		mov	ebp, [esp+64h-3Ch]
		xor	ecx, ebp
		mov	[esp+64h-54h], edi
		rol	ecx, 1
		mov	[esp+64h-30h], ecx
		mov	ecx, [esp+64h+8]
		mov	ebp, ecx
		and	ecx, edi
		or	ebp, edi
		mov	edi, [esp+64h-30h]
		and	ebp, [esp+64h-50h]
		mov	[esp+64h-4Ch], ebx
		rol	ebx, 5
		or	ebp, ecx
		mov	ecx, [esp+64h-48h]
		add	ebp, edi
		add	ebp, ecx
		mov	ecx, [esp+64h+8]
		rol	ecx, 1Eh
		lea	ebx, [ebx+ebp-70E44324h]
		mov	ebp, [esp+64h-24h]
		mov	edi, ecx
		mov	ecx, [esp+64h-0Ch]
		xor	ecx, ebp
		mov	ebp, [esp+64h-2Ch]
		xor	ecx, ebp
		mov	ebp, edi
		xor	ecx, eax
		mov	[esp+64h+8], edi
		rol	ecx, 1
		mov	[esp+64h-2Ch], ecx
		mov	ecx, [esp+64h-4Ch]
		or	ebp, ecx
		and	edi, ecx
		and	ebp, [esp+64h-54h]
		mov	[esp+64h-48h], ebx
		rol	ebx, 5
		or	ebp, edi
		mov	edi, [esp+64h-2Ch]
		add	ebp, edi
		mov	edi, [esp+64h-50h]
		add	ebp, edi
		rol	ecx, 1Eh
		lea	ebx, [ebx+ebp-70E44324h]
		mov	ebp, [esp+64h-20h]
		mov	edi, ecx
		mov	ecx, [esp+64h-08h]
		mov	[esp+64h-50h], ebx
		mov	[esp+64h-4Ch], edi
		xor	ecx, ebp
		mov	ebp, [esp+64h-28h]
		xor	ecx, ebp
		mov	ebp, [esp+64h-34h]
		xor	ecx, ebp
		mov	ebp, edi
		rol	ecx, 1
		mov	[esp+64h-28h], ecx
		mov	ecx, [esp+64h-48h]
		or	ebp, ecx
		and	edi, ecx
		and	ebp, [esp+64h+8]
		rol	ebx, 5
		or	ebp, edi
		mov	edi, [esp+64h-28h]
		add	ebp, edi
		mov	edi, [esp+64h-54h]
		add	ebp, edi
		rol	ecx, 1Eh
		lea	ebx, [ebx+ebp-70E44324h]
		mov	ebp, [esp+64h-1Ch]
		mov	edi, ecx
		mov	ecx, edx
		xor	ecx, ebp
		mov	ebp, [esp+64h-24h]
		xor	ecx, ebp
		mov	ebp, [esp+64h-30h]
		xor	ecx, ebp
		mov	ebp, edi
		rol	ecx, 1
		mov	[esp+64h-24h], ecx
		mov	ecx, [esp+64h-50h]
		or	ebp, ecx
		mov	[esp+64h-48h], edi
		and	ebp, [esp+64h-4Ch]
		and	edi, ecx
		mov	[esp+64h-54h], ebx
		or	ebp, edi
		mov	edi, [esp+64h-24h]
		add	ebp, edi
		mov	edi, [esp+64h+8]
		rol	ebx, 5
		add	ebp, edi
		rol	ecx, 1Eh
		lea	ebx, [ebx+ebp-70E44324h]
		mov	ebp, [esp+64h-20h]
		mov	edi, ecx
		mov	ecx, [esp+64h-18h]
		xor	ecx, ebp
		mov	ebp, [esp+64h-2Ch]
		xor	ecx, ebp
		mov	ebp, edi
		xor	ecx, esi
		mov	[esp+64h-50h], edi
		rol	ecx, 1
		mov	[esp+64h-20h], ecx
		mov	ecx, [esp+64h-54h]
		or	ebp, ecx
		and	edi, ecx
		and	ebp, [esp+64h-48h]
		mov	[esp+64h+8], ebx
		rol	ebx, 5
		or	ebp, edi
		mov	edi, [esp+64h-20h]
		add	ebp, edi
		mov	edi, [esp+64h-4Ch]
		add	ebp, edi
		rol	ecx, 1Eh
		lea	ebx, [ebx+ebp-70E44324h]
		mov	ebp, [esp+64h-1Ch]
		mov	edi, ecx
		mov	ecx, [esp+64h-14h]
		xor	ecx, ebp
		mov	ebp, [esp+64h-28h]
		xor	ecx, ebp
		mov	ebp, [esp+64h-3Ch]
		xor	ecx, ebp
		mov	[esp+64h-4Ch], ebx
		rol	ecx, 1
		mov	[esp+64h-54h], edi
		mov	[esp+64h-1Ch], ecx
		mov	ecx, [esp+64h+8]
		mov	ebp, ecx
		and	ecx, edi
		or	ebp, edi
		mov	edi, [esp+64h-1Ch]
		and	ebp, [esp+64h-50h]
		rol	ebx, 5
		or	ebp, ecx
		mov	ecx, [esp+64h-48h]
		add	ebp, edi
		add	ebp, ecx
		mov	ecx, [esp+64h+8]
		rol	ecx, 1Eh
		lea	ebx, [ebx+ebp-70E44324h]
		mov	ebp, [esp+64h-18h]
		mov	edi, ecx
		mov	ecx, [esp+64h-10h]
		xor	ecx, ebp
		mov	ebp, [esp+64h-24h]
		xor	ecx, ebp
		mov	ebp, edi
		xor	ecx, eax
		mov	[esp+64h+8], edi
		rol	ecx, 1
		mov	[esp+64h-18h], ecx
		mov	ecx, [esp+64h-4Ch]
		or	ebp, ecx
		and	edi, ecx
		and	ebp, [esp+64h-54h]
		mov	[esp+64h-48h], ebx
		rol	ebx, 5
		or	ebp, edi
		mov	edi, [esp+64h-18h]
		add	ebp, edi
		mov	edi, [esp+64h-50h]
		add	ebp, edi
		rol	ecx, 1Eh
		lea	ebx, [ebx+ebp-70E44324h]
		mov	ebp, [esp+64h-14h]
		mov	edi, ecx
		mov	ecx, [esp+64h-0Ch]
		xor	ecx, ebp
		mov	ebp, [esp+64h-20h]
		xor	ecx, ebp
		mov	ebp, [esp+64h-34h]
		xor	ecx, ebp
		mov	ebp, edi
		rol	ecx, 1
		mov	[esp+64h-14h], ecx
		mov	ecx, [esp+64h-48h]
		or	ebp, ecx
		mov	[esp+64h-4Ch], edi
		and	ebp, [esp+64h+8]
		and	edi, ecx
		mov	[esp+64h-50h], ebx
		or	ebp, edi
		mov	edi, [esp+64h-14h]
		add	ebp, edi
		mov	edi, [esp+64h-54h]
		rol	ebx, 5
		add	ebp, edi
		rol	ecx, 1Eh
		lea	edi, [ebx+ebp-70E44324h]
		mov	ebp, [esp+64h-10h]
		mov	ebx, ecx
		mov	ecx, [esp+64h-08h]
		xor	ecx, ebp
		mov	ebp, [esp+64h-1Ch]
		xor	ecx, ebp
		mov	ebp, [esp+64h-30h]
		xor	ecx, ebp
		mov	ebp, edi
		rol	ecx, 1
		rol	ebp, 5
		mov	[esp+64h-44h], ebp
		mov	ebp, [esp+64h-4Ch]
		mov	[esp+64h-54h], edi
		mov	edi, [esp+64h-50h]
		xor	ebp, ebx
		mov	[esp+64h-48h], ebx
		xor	ebp, edi
		mov	ebx, [esp+64h+8]
		add	ebp, ecx
		add	ebp, ebx
		mov	ebx, [esp+64h-44h]
		rol	edi, 1Eh
		lea	ebx, [ebx+ebp-359D3E2Ah]
		mov	ebp, edi
		mov	edi, edx
		mov	[esp+64h-50h], ebp
		xor	edi, [esp+64h-0Ch]
		mov	[esp+64h+8], ebx
		xor	edx, ecx
		xor	edi, [esp+64h-18h]
		xor	edi, [esp+64h-2Ch]
		rol	edi, 1
		mov	[esp+64h-0Ch], edi
		mov	edi, [esp+64h-48h]
		xor	edi, ebp
		mov	ebp, [esp+64h-54h]
		xor	edi, ebp
		mov	ebp, [esp+64h-0Ch]
		add	edi, ebp
		mov	ebp, [esp+64h-4Ch]
		add	edi, ebp
		mov	ebp, [esp+64h-14h]
		rol	ebx, 5
		lea	ebx, [edi+ebx-359D3E2Ah]
		mov	edi, [esp+64h-54h]
		rol	edi, 1Eh
		mov	[esp+64h-54h], edi
		mov	edi, [esp+64h-08h]
		xor	edi, ebp
		mov	ebp, [esp+64h-28h]
		xor	edi, ebp
		mov	ebp, [esp+64h-50h]
		xor	edi, esi
		mov	[esp+64h-4Ch], ebx
		rol	edi, 1
		mov	[esp+64h-08h], edi
		mov	edi, [esp+64h+8]
		xor	edi, ebp
		mov	ebp, [esp+64h-54h]
		xor	edi, ebp
		mov	ebp, [esp+64h-08h]
		add	edi, ebp
		mov	ebp, [esp+64h-48h]
		rol	ebx, 5
		add	edi, ebp
		mov	ebp, [esp+64h-24h]
		xor	edx, ebp
		mov	ebp, [esp+64h-3Ch]
		lea	ebx, [edi+ebx-359D3E2Ah]
		mov	edi, [esp+64h+8]
		rol	edi, 1Eh
		xor	edx, ebp
		mov	ebp, [esp+64h-4Ch]
		mov	[esp+64h+8], edi
		xor	edi, ebp
		mov	ebp, [esp+64h-54h]
		mov	[esp+64h-48h], ebx
		rol	edx, 1
		xor	edi, ebp
		mov	ebp, [esp+64h-50h]
		add	edi, edx
		rol	ebx, 5
		add	edi, ebp
		lea	ebx, [edi+ebx-359D3E2Ah]
		mov	edi, [esp+64h-4Ch]
		rol	edi, 1Eh
		mov	ebp, edi
		mov	edi, [esp+64h-0Ch]
		xor	edi, [esp+64h-20h]
		mov	[esp+64h-50h], ebx
		mov	[esp+64h-4Ch], ebp
		xor	edi, eax
		xor	edi, esi
		rol	edi, 1
		rol	ebx, 5
		mov	[esp+64h-44h], ebx
		mov	ebx, [esp+64h+8]
		mov	[esp+64h-40h], edi
		mov	esi, [esp+64h-48h]
		xor	ebx, ebp
		xor	ebx, esi
		add	ebx, edi
		mov	edi, [esp+64h-54h]
		add	ebx, edi
		mov	edi, [esp+64h-44h]
		rol	esi, 1Eh
		mov	ebp, esi
		mov	esi, [esp+64h-08h]
		lea	ebx, [ebx+edi-359D3E2Ah]
		mov	edi, esi
		xor	edi, [esp+64h-1Ch]
		mov	[esp+64h-48h], ebp
		mov	[esp+64h-54h], ebx
		xor	edi, [esp+64h-34h]
		xor	edi, [esp+64h-3Ch]
		rol	edi, 1
		mov	[esp+64h-3Ch], edi
		mov	edi, [esp+64h-4Ch]
		xor	edi, ebp
		mov	ebp, [esp+64h-50h]
		xor	edi, ebp
		mov	ebp, [esp+64h-3Ch]
		add	edi, ebp
		mov	ebp, [esp+64h+8]
		rol	ebx, 5
		add	edi, ebp
		lea	ebx, [edi+ebx-359D3E2Ah]
		mov	edi, [esp+64h-50h]
		rol	edi, 1Eh
		mov	ebp, edi
		mov	edi, edx
		xor	edi, [esp+64h-18h]
		mov	[esp+64h+8], ebx
		mov	[esp+64h-50h], ebp
		xor	edi, [esp+64h-30h]
		xor	edi, eax
		mov	eax, [esp+64h-54h]
		rol	edi, 1
		rol	ebx, 5
		mov	[esp+64h-44h], ebx
		mov	ebx, [esp+64h-48h]
		xor	ebx, ebp
		mov	ebp, [esp+64h-4Ch]
		xor	ebx, eax
		add	ebx, edi
		add	ebx, ebp
		mov	ebp, [esp+64h-44h]
		rol	eax, 1Eh
		lea	ebx, [ebx+ebp-359D3E2Ah]
		mov	ebp, [esp+64h-2Ch]
		mov	[esp+64h-54h], eax
		mov	eax, [esp+64h-14h]
		xor	eax, ebp
		mov	ebp, [esp+64h-34h]
		xor	eax, ebp
		mov	ebp, [esp+64h-40h]
		xor	eax, ebp
		mov	ebp, [esp+64h-50h]
		rol	eax, 1
		mov	[esp+64h-34h], eax
		mov	eax, [esp+64h+8]
		xor	eax, ebp
		mov	ebp, [esp+64h-54h]
		xor	eax, ebp
		mov	ebp, [esp+64h-34h]
		add	eax, ebp
		mov	ebp, [esp+64h-48h]
		mov	[esp+64h-4Ch], ebx
		add	eax, ebp
		rol	ebx, 5
		lea	ebx, [eax+ebx-359D3E2Ah]
		mov	eax, [esp+64h+8]
		rol	eax, 1Eh
		mov	ebp, eax
		mov	eax, ecx
		xor	eax, [esp+64h-28h]
		mov	[esp+64h-48h], ebx
		mov	[esp+64h+8], ebp
		xor	eax, [esp+64h-30h]
		xor	eax, [esp+64h-3Ch]
		rol	eax, 1
		mov	[esp+64h-30h], eax
		mov	eax, [esp+64h-4Ch]
		xor	ebp, eax
		mov	eax, [esp+64h-54h]
		xor	ebp, eax
		mov	eax, [esp+64h-30h]
		add	ebp, eax
		mov	eax, [esp+64h-50h]
		add	ebp, eax
		mov	eax, [esp+64h-4Ch]
		rol	ebx, 5
		rol	eax, 1Eh
		lea	ebx, [ebx+ebp-359D3E2Ah]
		mov	ebp, eax
		mov	eax, [esp+64h-0Ch]
		mov	[esp+64h-4Ch], ebp
		xor	eax, [esp+64h-24h]
		mov	[esp+64h-50h], ebx
		xor	eax, [esp+64h-2Ch]
		xor	eax, edi
		rol	eax, 1
		mov	[esp+64h-2Ch], eax
		mov	eax, [esp+64h+8]
		xor	eax, ebp
		mov	ebp, [esp+64h-48h]
		xor	eax, ebp
		mov	ebp, [esp+64h-2Ch]
		add	eax, ebp
		mov	ebp, [esp+64h-54h]
		add	eax, ebp
		rol	ebx, 5
		lea	ebx, [eax+ebx-359D3E2Ah]
		mov	eax, [esp+64h-48h]
		rol	eax, 1Eh
		mov	ebp, eax
		mov	eax, esi
		xor	eax, [esp+64h-20h]
		mov	[esp+64h-48h], ebp
		mov	[esp+64h-54h], ebx
		xor	eax, [esp+64h-28h]
		xor	eax, [esp+64h-34h]
		rol	eax, 1
		mov	[esp+64h-28h], eax
		mov	eax, [esp+64h-4Ch]
		xor	eax, ebp
		mov	ebp, [esp+64h-50h]
		xor	eax, ebp
		mov	ebp, [esp+64h-28h]
		add	eax, ebp
		mov	ebp, [esp+64h+8]
		rol	ebx, 5
		add	eax, ebp
		lea	ebx, [eax+ebx-359D3E2Ah]
		mov	eax, [esp+64h-50h]
		rol	eax, 1Eh
		mov	ebp, eax
		mov	eax, edx
		xor	eax, [esp+64h-1Ch]
		mov	[esp+64h-50h], ebp
		mov	[esp+64h+8], ebx
		xor	eax, [esp+64h-24h]
		xor	eax, [esp+64h-30h]
		rol	eax, 1
		mov	[esp+64h-24h], eax
		mov	eax, [esp+64h-48h]
		xor	eax, ebp
		mov	ebp, [esp+64h-54h]
		xor	eax, ebp
		mov	ebp, [esp+64h-24h]
		add	eax, ebp
		mov	ebp, [esp+64h-4Ch]
		rol	ebx, 5
		add	eax, ebp
		lea	ebx, [eax+ebx-359D3E2Ah]
		mov	eax, [esp+64h-54h]
		rol	eax, 1Eh
		mov	[esp+64h-54h], eax
		mov	eax, [esp+64h-18h]
		mov	[esp+64h-4Ch], ebx
		mov	ebp, [esp+64h-20h]
		xor	eax, ebp
		mov	ebp, [esp+64h-2Ch]
		xor	eax, ebp
		mov	ebp, [esp+64h-40h]
		xor	eax, ebp
		mov	ebp, [esp+64h-50h]
		rol	eax, 1
		mov	[esp+64h-20h], eax
		mov	eax, [esp+64h+8]
		xor	eax, ebp
		mov	ebp, [esp+64h-54h]
		xor	eax, ebp
		mov	ebp, [esp+64h-20h]
		add	eax, ebp
		mov	ebp, [esp+64h-48h]
		add	eax, ebp
		rol	ebx, 5
		lea	ebx, [eax+ebx-359D3E2Ah]
		mov	eax, [esp+64h+8]
		rol	eax, 1Eh
		mov	ebp, eax
		mov	eax, [esp+64h-14h]
		xor	eax, [esp+64h-1Ch]
		mov	[esp+64h+8], ebp
		mov	[esp+64h-48h], ebx
		xor	eax, [esp+64h-28h]
		xor	eax, [esp+64h-3Ch]
		rol	eax, 1
		mov	[esp+64h-1Ch], eax
		mov	eax, [esp+64h-4Ch]
		xor	ebp, eax
		mov	eax, [esp+64h-54h]
		xor	ebp, eax
		mov	eax, [esp+64h-1Ch]
		add	ebp, eax
		mov	eax, [esp+64h-50h]
		add	ebp, eax
		mov	eax, [esp+64h-4Ch]
		rol	ebx, 5
		rol	eax, 1Eh
		lea	ebx, [ebx+ebp-359D3E2Ah]
		mov	ebp, eax
		mov	eax, ecx
		mov	[esp+64h-50h], ebx
		xor	eax, [esp+64h-18h]
		mov	[esp+64h-4Ch], ebp
		xor	eax, [esp+64h-24h]
		xor	eax, edi
		mov	edi, [esp+64h-48h]
		rol	eax, 1
		rol	ebx, 5
		mov	[esp+64h-44h], ebx
		mov	ebx, [esp+64h+8]
		xor	ebx, ebp
		mov	ebp, [esp+64h-54h]
		xor	ebx, edi
		add	ebx, eax
		add	ebx, ebp
		mov	ebp, [esp+64h-44h]
		rol	edi, 1Eh
		lea	ebx, [ebx+ebp-359D3E2Ah]
		mov	ebp, edi
		mov	edi, [esp+64h-0Ch]
		mov	[esp+64h-48h], ebp
		xor	edi, [esp+64h-14h]
		mov	[esp+64h-54h], ebx
		xor	edi, [esp+64h-20h]
		xor	edi, [esp+64h-34h]
		rol	edi, 1
		mov	[esp+64h-14h], edi
		mov	edi, [esp+64h-4Ch]
		xor	edi, ebp
		mov	ebp, [esp+64h-50h]
		xor	edi, ebp
		mov	ebp, [esp+64h-14h]
		add	edi, ebp
		mov	ebp, [esp+64h+8]
		rol	ebx, 5
		add	edi, ebp
		lea	ebx, [edi+ebx-359D3E2Ah]
		mov	edi, [esp+64h-50h]
		mov	[esp+64h+8], ebx
		rol	edi, 1Eh
		mov	ebp, edi
		mov	edi, esi
		xor	edi, ecx
		mov	ecx, [esp+64h-1Ch]
		xor	edi, ecx
		mov	ecx, [esp+64h-30h]
		xor	edi, ecx
		mov	ecx, [esp+64h-54h]
		rol	edi, 1
		rol	ebx, 5
		mov	[esp+64h-44h], ebx
		mov	ebx, [esp+64h-48h]
		xor	ebx, ebp
		mov	[esp+64h-50h], ebp
		mov	ebp, [esp+64h-4Ch]
		xor	ebx, ecx
		add	ebx, edi
		add	ebx, ebp
		mov	ebp, [esp+64h-44h]
		rol	ecx, 1Eh
		lea	ebx, [ebx+ebp-359D3E2Ah]
		mov	ebp, [esp+64h-0Ch]
		mov	[esp+64h-54h], ecx
		mov	ecx, edx
		xor	ecx, ebp
		mov	ebp, [esp+64h-2Ch]
		xor	ecx, eax
		mov	[esp+64h-4Ch], ebx
		xor	ecx, ebp
		mov	ebp, [esp+64h+8]
		mov	eax, ebx
		mov	ebx, [esp+64h-50h]
		xor	ebp, ebx
		mov	ebx, [esp+64h-54h]
		rol	ecx, 1
		xor	ebp, ebx
		xor	edx, edi
		add	ebp, ecx
		mov	ecx, [esp+64h-48h]
		rol	eax, 5
		add	ebp, ecx
		mov	edi, [esp+64h-24h]
		xor	edx, edi
		lea	ecx, [eax+ebp-359D3E2Ah]
		mov	ebp, [esp+64h-14h]
		mov	eax, [esp+64h+8]
		xor	esi, ebp
		mov	ebp, [esp+64h-28h]
		xor	esi, ebp
		mov	ebp, [esp+64h-40h]
		rol	eax, 1Eh
		xor	esi, ebp
		mov	[esp+64h+8], eax
		mov	ebp, eax
		mov	eax, [esp+64h-4Ch]
		rol	esi, 1
		xor	ebp, eax
		mov	[esp+64h-08h], esi
		xor	ebp, ebx
		mov	ebx, [esp+64h-08h]
		mov	edi, [esp+64h+8]
		add	ebp, ebx
		mov	ebx, [esp+64h-50h]
		mov	esi, ecx
		rol	esi, 5
		add	ebp, ebx
		rol	eax, 1Eh
		lea	esi, [esi+ebp-359D3E2Ah]
		mov	ebx, eax
		mov	eax, [esp+64h-3Ch]
		mov	ebp, edi
		xor	edx, eax
		xor	ebp, ebx
		mov	eax, esi
		xor	ebp, ecx
		rol	edx, 1
		rol	eax, 5
		add	ebp, edx
		add	ebp, [esp+64h-54h]
		lea	ebp, [eax+ebp-359D3E2Ah]
		mov	eax, [esp+64h+4]
		mov	edx, [eax]
		add	edx, ebp
		mov	[eax], edx
		mov	edx, [eax+4]
		add	edx, esi
		mov	[eax+4], edx
		mov	edx, [eax+8]
		rol	ecx, 1Eh
		add	ecx, edx
		mov	[eax+8], ecx
		mov	ecx, [eax+0Ch]
		add	ecx, ebx
		mov	[eax+0Ch], ecx
		mov	ecx, [eax+10h]
		add	ecx, edi
		pop	edi
		pop	esi
		pop	ebp
		mov	[eax+10h], ecx
		pop	ebx
		add	esp, 60h
