import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_customization_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final Widget? leading;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final customization = Provider.of<AppCustomizationProvider>(context);
    final displayTitle = title ?? customization.appBarTitle;
    final logoBytes = customization.logoBytes;
    final theme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
      title: null,
      // إضافة مرونة للخلفية
      flexibleSpace: Container(
        decoration: BoxDecoration(
          // تدرج لوني 
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primaryContainer,
            ],
          ),
          // إطار خفيف (ظل سفلي) 
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        // محتوى الشريط المخصص
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                ?leading,
                if (leading == null && automaticallyImplyLeading)
                  const SizedBox(width: 48), // حجز مساحة زر الرجوع التلقائي
                
                Expanded(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            displayTitle,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onPrimary,
                              shadows: [
                                Shadow(
                                  color: theme.colorScheme.shadow.withValues(alpha: 0.2),
                                  blurRadius: 2,
                                  offset: const Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'للتكافل والاستدامة',
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.surface.withValues(alpha: 0.4),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.shadow.withValues(alpha: 0.15),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.9),
                          backgroundImage: logoBytes != null ? MemoryImage(logoBytes) : null,
                          child: logoBytes == null
                              ? Icon(
                                  Icons.family_restroom,
                                  size: 24,
                                  color: theme.colorScheme.primary,
                                )
                              : null,
                        ),
                      ),
                      
                      const Spacer(),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                
                if (actions != null) ...actions!,
              ],
            ),
          ),
        ),
      ),
      elevation: 0,
      iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
      actionsIconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}